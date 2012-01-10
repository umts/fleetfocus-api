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
  self.primary_key = 'row_id'
  @@have_tried_to_reconnect = false
  
  #overriding rails find method to work with fueltask
  def self.find(*args)
    json_return = {:connection_valid => false, :error => "" ,:fueling => nil}
    
    begin
      options = args.extract_options!
      json_return[:fueling] = with_scope :find => options do
        super(args.first,
        :select => "qty_fuel as amount, meter_1 as mileage, ftk_date as time_at, row_id as fuel_focus_row_id, X_datetime_insert as time_at_insertion, EQ_equip_no"
        )
      end
      
      json_return[:connection_valid] = true
      
      if json_return[:fueling] == []
        @@have_tried_to_reconnect = false
        json_return[:error] = "Your query has returned no results. Please contact MIS for further assitance. (vehicle by id)"
      end    
    rescue
      if @@have_tried_to_reconnect
        @@have_tried_to_reconnect = false
        json_return[:error] = "You  are currently not connected to the database. Please contact MIS for further assitance. (vehicle by id)"
      else
        ActiveRecord::Base.establish_connection(
          :adapter => 'sqlserver',
          :host => 'FILL_THIS_IN',
          :database => 'FILL_THIS_IN',
          :username => 'FILL_THIS_IN',
          :password => 'FILL_THIS_IN'
          )
        @@have_tried_to_reconnect = true
        retry
      end
    end
    
    json_return
    
  end
      
end


################################################################################################################
# This section is the collection of routing api's. The first matching route in this list will be called first. #
################################################################################################################

before do
  
end

# Obtain all records for a vehicle by its id
get '/vehicle/:id' do
  @vehicle_by_id = SqlServer2000Connection.find(:all, :conditions => ["EQ_equip_no = ?", params[:id]], :order => "ftk_date desc")
  content_type :json
  @vehicle_by_id.to_json
  #haml :vehicle_id
end

# Obtain all records for a vehicle by its id which occur after the provided datetime
get '/vehicle/:id/:datetime' do
  @vehicle_by_id_datetime = SqlServer2000Connection.find(:all, :conditions => ["EQ_equip_no = ? AND ftk_date > ?", params[:id], Time.at(params[:datetime].to_f)], :order => "ftk_date desc")
  content_type :json
  @vehicle_by_id_datetime.to_json
  #haml :vehicle_id_datetime
end

# Obtain all records for a vehicle by its id which occur between the provided datetimes
get '/vehicle/:id/:start_datetime/:end_datetime' do
  @vehicle_by_id_daterange = SqlServer2000Connection.find(:all, :conditions => ["EQ_equip_no = ? AND ftk_date > ? AND ftk_date < ?", params[:id], Time.at(params[:start_datetime].to_f), Time.at(params[:end_datetime].to_f)], :order => "ftk_date desc")
  content_type :json
  @vehicle_by_id_daterange.to_json
  #haml :vehicle_id_daterange
end

# Obtain records for all vehicles which occur after the provided datetime
get '/all/:datetime' do
  @all_vehicles_by_datetime = SqlServer2000Connection.find(:all, :conditions => ["ftk_date > ?", Time.at(params[:datetime].to_f)], :order => "ftk_date desc")
  content_type :json
  @all_vehicles_by_datetime.to_json
  #haml :all_vehicles_datetime
end

# Obtain records for all vehicles which occur between two dates
get '/all/:start_datetime/:end_datetime' do
  @all_vehicles_by_daterange = SqlServer2000Connection.find(:all, :conditions => ["ftk_date > ? AND ftk_date < ?", Time.at(params[:start_datetime].to_f), Time.at(params[:end_datetime].to_f)], :order => "ftk_date desc")
  content_type :json
  @all_vehicles_by_daterange.to_json
  #haml :all_vehicles_daterange
end

# The root URL
get '/*' do
  404
end

error 404 do
  'Eror 404. Webpage Not Found.'
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
