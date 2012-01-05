require 'rubygems'
require 'sinatra'
require 'active_record'
require 'activerecord-sqlserver-adapter'
require 'tiny_tds'
require 'haml'
require 'uri'
require 'json'
require 'date'

############################################################
# This section establishes the Msql Server 2000 connection #
############################################################

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlserver',
  :host => 'FILL_THIS_IN',
  :database => 'FILL_THIS_IN',
  :username => 'FILL_THIS_IN',
  :password => 'FILL_THIS_IN'
)

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
        :conditions => ["EQ_equip_no = ? AND ftk_date > ?", vehicle_id, Time.at(datetime.to_f)]
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
        :conditions => ["ftk_date > ?", Time.at(datetime.to_f)]
        )
      end
      return fuelings
    #rescue
    #end
  end
  
  # Obtain records for all vehicles which occur between the two dates
  def self.find_all_for_vehicle_id_and_daterange(vehicle_id, start_datetime, end_datetime, options = {})
    #begin
      fuelings = with_scope :find => options do
        find(:all, 
        :conditions => ["EQ_equip_no = ? AND ftk_date > ? AND ftk_date < ?", vehicle_id, Time.at(start_datetime.to_f), Time.at(end_datetime.to_f)]
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
        :conditions => ["ftk_date > ? AND ftk_date < ?", Time.at(start_datetime.to_f), Time.at(end_datetime.to_f)]
        )
      end
      return fuelings
    #rescue
    #end
  end
  
  #overriding rails find method to work with fueltask
  def self.find(*args)
    #begin
    options = args.extract_options!
    fuelings = with_scope :find => options do
      super(args.first,
        :select => "qty_fuel as amount, meter_1 as mileage, ftk_date as time_at, row_id as fuel_focus_row_id, X_datetime_insert as time_at_insertion, EQ_equip_no"
        )
        end
        return fuelings
    #rescue
    #end
  end
      
end


################################################################################################################
# This section is the collection of routing api's. The first matching route in this list will be called first. #
################################################################################################################

before do
  
end

# Obtain all records for a vehicle by its id
get '/vehicle/:id' do
  @vehicle_by_id = SqlServer2000Connection.find_all_for_vehicle_id("#{params[:id]}", :order => "ftk_date desc")
  #@vehicle_by_id = "Seeking records of vehicle #{params[:id]}"
  content_type :json
  @vehicle_by_id.to_json
  #haml :vehicle_id
end

# Obtain all records for a vehicle by its id which occur after the provided datetime
get '/vehicle/:id/:datetime' do
  @vehicle_by_id_datetime = SqlServer2000Connection.find_all_for_vehicle_id_and_datetime("#{params[:id]}", "#{params[:datetime]}", :order => "ftk_date desc")
  #@vehicle_by_id_datetime = "Seeking records of vehicle #{params[:id]} which come after #{params[:datetime]}"
  content_type :json
  @vehicle_by_id_datetime.to_json
  #haml :vehicle_id_datetime
end

# Obtain all records for a vehicle by its id which occur after the provided datetime
get '/vehicle/:id/:start_datetime/:end_datetime' do
  @vehicle_by_id_daterange = SqlServer2000Connection.find_all_for_vehicle_id_and_daterange("#{params[:id]}", "#{params[:start_datetime]}", "#{params[:end_datetime]}", :order => "ftk_date desc")
  #@vehicle_by_id_daterange = "Seeking records of vehicle #{params[:id]} which come after #{params[:datetime]}"
  content_type :json
  @vehicle_by_id_daterange.to_json
  #haml :vehicle_id_daterange
end

# Obtain records for all vehicles which occur after the provided datetime
get '/all/:datetime' do
  @all_vehicles_by_datetime = SqlServer2000Connection.find_all_vehicles_for_datetime("#{params[:datetime]}", :order => "ftk_date desc")
  #@all_vehicles_by_datetime = "Seeking records for all vehicles which come after #{params[:datetime]}"
  content_type :json
  @all_vehicles_by_datetime.to_json
  #haml :all_vehicles_datetime
end

# Obtain records for all vehicles which occur between two dates
get '/all/:start_datetime/:end_datetime' do
  @all_vehicles_by_daterange = SqlServer2000Connection.find_all_vehicles_for_daterange("#{params[:start_datetime]}", "#{params[:end_datetime]}", :order => "ftk_date desc")
  #@all_vehicles_by_daterange = "Seeking records for all vehicles which come after #{params[:start_datetime]} and before #{params[:end_datetime]}"
  content_type :json
  @all_vehicles_by_daterange.to_json
  #haml :all_vehicles_daterange
end

get '/verify' do
  @connected = true
  
  begin
    @vehicle_by_id = SqlServer2000Connection.find_all_for_vehicle_id(3201, :limit => 1)
  rescue
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlserver',
      :host => 'FILL_THIS_IN',
      :database => 'FILL_THIS_IN',
      :username => 'FILL_THIS_IN',
      :password => 'FILL_THIS_IN'
    )
    @connected = false
  end
  
  #content_type :json
  #@conected.to_json
  haml :verify
end

# The root URL
get '/*' do
  403
end

error 403 do
  'ACCESS FORBIDDEN!!! HOW DARE YOU TRY TO ENTER!!! YOU SHALL NEVER GAIN ENTRY AGAIN YOU FILTHY ANIMAL!!!'
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
    =@vehicle_by_id.to_json

@@vehicle_id_datetime
%html
  %head
  %body
    =@vehicle_by_id_datetime.to_json
    
@@vehicle_id_daterange
%html
  %head
  %body
    =@vehicle_by_id_daterange.to_json
    
@@all_vehicles_datetime
%html
  %head
  %body
    =@all_vehicles_by_datetime.to_json
    
@@all_vehicles_daterange
%html
  %head
  %body
    =@all_vehicles_by_daterange.to_json

@@verify
%html
  %head
    %body
      =@connected
     
