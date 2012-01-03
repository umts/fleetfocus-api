require 'rubygems'
require 'sinatra'
require 'active_record'
require 'activerecord-sqlserver-adapter'
require 'tiny_tds'
require 'haml'

#class Fueltask < ActiveRecord::Base
#  establish_connection :fueltask
#end

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlserver',
  :host => 'FILL_THIS_IN',
  :database => 'FILL_THIS_IN',
  :username => 'FILL_THIS_IN',
  :password => 'FILL_THIS_IN',
)

class Fueltask < ActiveRecord::Base
end

class FueltaskFuel < Fueltask
  set_table_name 'emsdba.FTK_MAIN'
  
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
  
  #overriding rails find method to work with fueltask
  def self.find(*args)
    rescue_me
    options = args.extract_options!
    fuelings = with_scope :find => options do
      super(args.first,
        :select => "qty_fuel as amount, meter_1 as mileage, ftk_date as time_at, row_id as fuel_focus_row_id, X_datetime_insert as time_at_insertion"
        )
    end
    return fuelings
  end
  
  def self.rescue_me
    begin
      column_names
    rescue
    end
  end

  def mileage
    return Mileage.new(:mileage => super, :time_at => time_at)
  end
  
end


get '/' do
  @stuff = FueltaskFuel.find_all_for_vehicle_name(3201, :order => "ftk_date desc")
  haml :index
end

__END__

@@index
%html
  %head
  %body
    =for thing in @stuff
      =thing.fuel_focus_row_id
      ,
      =thing.time_at_insertion
      <br>
      
