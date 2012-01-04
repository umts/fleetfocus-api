require 'rubygems'
require 'sinatra'
require 'active_record'
require 'activerecord-sqlserver-adapter'
require 'tiny_tds'
require 'haml'
require 'uri'

#URI.incode
#URI.decode

############################################################
# This section establishes the Msql Server 2000 connection #
############################################################

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlserver',
  :host => 'FILL_THIS_IN',
  :database => 'FILL_THIS_IN',
  :username => 'FILL_THIS_IN',
  :password => 'FILL_THIS_IN',
)

# dt=Datetime.now
# dt.strftime('%s')
##########################################################################################
# This section takes the parameters from url calls and obtains data from the msql server #
##########################################################################################

class SqlServer2000Connection < ActiveRecord::Base
  set_table_name 'emsdba.FTK_MAIN'
  
  # Obtain all records for a vehicle by its name
  def self.find_all_for_vehicle_name(vehicle_name, options = {})
    #begin
      fuelings = with_scope :find => options do
        find(:all, 
        :conditions => ["EQ_equip_no = ?", vehicle_name]
        )
      end
      return fuelings
    #rescue
    #end
  end
  
  # Obtain all records for a vehicle by its id
  def self.find_all_for_vehicle_id(vehicle_id, options = {})
    #begin
      fuelings = with_scope :find => options do
        find(:all, 
        :conditions => ["EQ_equip_no = ?", vehicle_id]
        )
      end
      return fuelings
    #rescue
    #end
  end
  
  # Obtain all records for a vehicle by its id which occur after the provided datetime
  def self.find_all_for_vehicle_id_and_datetime(vehicle_id, datetime, options = {})
    #begin
      fuelings = with_scope :find => options do
        find(:all, 
        :conditions => ["EQ_equip_no = ?", vehicle_id, datetime]
        )
      end
      return fuelings
    #rescue
    #end
  end
  
  # Obtain records for all vehicles which occur after the provided datetime
  def self.find_all_vehicles_for_datetime(datetime, options = {})
    #begin
      fuelings = with_scope :find => options do
        find(:all, 
        :conditions => ["EQ_equip_no = ?", datetime]
        )
      end
      return fuelings
    #rescue
    #end
  end
  
  # Obtain records for all vehicles which occur between two dates
  def self.find_all_vehicles_for_daterange(start_datetime, end_datetime, options = {})
    #begin
      fuelings = with_scope :find => options do
        find(:all, 
        :conditions => ["EQ_equip_no = ?", start_datetime, end_datetime]
        )
      end
      return fuelings
    #rescue
    #end
  end
  
  #overriding rails find method to work with fueltask
  def self.find(*args)
    options = args.extract_options!
    fuelings = with_scope :find => options do
      super(args.first,
        :select => "qty_fuel as amount, meter_1 as mileage, ftk_date as time_at, row_id as fuel_focus_row_id, X_datetime_insert as time_at_insertion, EQ_equip_no"
        )
    end
    return fuelings
  end
end


###################################################
# This section is the collection of routing api's #
###################################################

# The root URL
get '/' do
  @root = "This is the root URL"
  haml :index
end

# Obtain all records for a vehicle by its id
get '/vehicle/:id' do
  @vehicle_by_id = SqlServer2000Connection.find_all_for_vehicle_id("#{params[:id]}", :order => "ftk_date desc")
  #@vehicle_by_id = "Seeking records of vehicle #{params[:id]}"
  haml :vehicle_id
end

# Obtain all records for a vehicle by its id which occur after the provided datetime
get '/vehicle/:id/:datetime' do
  #@vehicle_by_id_datetime = SqlServer2000Connection.find_all_for_vehicle_id_and_datetime("#{params[:id]}", "#{params[:datetime]}", :order => "ftk_date desc")
  @vehicle_by_id_datetime = "Seeking records of vehicle #{params[:id]} which come after #{params[:datetime]}"
  haml :vehicle_id_datetime
end

# Obtain records for all vehicles which occur after the provided datetime
get '/all/:datetime' do
  #@all_vehicles_by_datetime = SqlServer2000Connection.find_all_vehicles_for_datetime("#{params[:datetime]}", :order => "ftk_date desc")
  @all_vehicles_by_datetime = "Seeking records for all vehicles which come after #{params[:datetime]}"
  haml :all_vehicles_datetime
end

# Obtain records for all vehicles which occur between two dates
get '/all/:start_datetime/:end_datetime' do
  #@all_vehicles_by_daterange = SqlServer2000Connection.find_all_vehicles_for_daterange("#{params[:start_datetime]}", "#{params[:end_datetime]}", :order => "ftk_date desc")
  @all_vehicles_by_daterange = "Seeking records for all vehicles which come after #{params[:start_datetime]} and before #{params[:end_datetime]}"
  haml :all_vehicles_daterange
end

__END__


###########################################################
# This section handles rendering the views for each route #
###########################################################

@@index
%html
  %head
  %body
    =@root
@@vehicle_id
%html
  %head
  %body
    =for thing in @vehicle_by_id
      =thing.EQ_equip_no
      ,
      =thing.fuel_focus_row_id
      ,
      =thing.time_at_insertion
      ,
      =thing.amount
      ,
      =thing.mileage
      <br>
@@vehicle_id_datetime
%html
  %head
  %body
    =@vehicle_by_id_datetime
@@all_vehicles_datetime
%html
  %head
  %body
    =@all_vehicles_by_datetime
@@all_vehicles_daterange
%html
  %head
  %body
    =@all_vehicles_by_daterange     
