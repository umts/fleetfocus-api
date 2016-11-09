environment = ENV['RACK_ENV'] || "development"
config = Hashie::Hash.new
config.replace(YAML.load_file(File.join(File.dirname( __FILE__ ), "config", "database.yml"))[environment])
database_config = config.to_hash(symbolize_keys: true)

if environment == 'development'
  gateway = Net::SSH::Gateway.new(database_config.delete(:gateway),
                                  database_config.delete(:gateway_user))
  port = gateway.open('127.0.0.1', database_config[:port])
  database_config.merge!(port: port)
end
ActiveRecord::Base.establish_connection( database_config )

class Fueling < ActiveRecord::Base
  self.table_name = 'emsdba.FTK_MAIN'
  self.primary_key = 'row_id'

  default_scope do
    order('ftk_date DESC').select 'qty_fuel AS amount',
                                   'meter_1 AS mileage',
                                   'ftk_date AS time_at',
                                   'row_id AS fuel_focus_row_id',
                                   'X_datetime_insert AS time_at_insertion',
                                   'EQ_equip_no'
  end
end

class EAMApp < Sinatra::Base
  get '/vehicle/:name' do
    fuelings = Fueling.where('EQ_equip_no = ?', params[:name])
    content_type :json
    build_response(fuelings).to_json
  end

  get '/*' do
    404
  end

  error 404 do
    'Error 404. Webpage Not Found.'
  end

  private

  def build_response(fuelings)
    if fulelings.present?
      return { connection_valid: true,
               error: '',
               fueling: fuelings
             }
    else
      return { connection_valid: false,
               error: 'Your query has returned no results. Please contact IT for further assitance.'
             }
    end
  end
end
