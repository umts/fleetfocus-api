environment = ENV['RACK_ENV'] || "development"
config = Hashie::Hash.new
config.replace(YAML.load_file(File.join(File.dirname( __FILE__ ), "config", "database.yml"))[environment])
database_config = config.to_hash(symbolize_keys: true)
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

  access_log = File.new("#{settings.root}/log/#{settings.environment}_access.log", 'a+')
  error_log = File.new("#{settings.root}/log/#{settings.environment}_error.log", 'a+')
  access_log.sync = true
  error_log.sync = true

  configure do
    enable :logging
    use Rack::CommonLogger, access_log
  end

  before do
    env["rack.errors"] = error_log
    content_type :json
  end

  get '/vehicle/:name' do
    fuelings = Fueling.where('EQ_equip_no = ?', params[:name])
    build_response(fuelings).to_json
  end

  get '/vehicle/:name/:datetime' do
    start_date = Time.at(params[:datetime].to_i)
    fuelings = Fueling.where('EQ_equip_no = ? AND ftk_date > ?',
                             params[:name],
                             start_date)
    build_response(fuelings).to_json
  end

  get '/vehicle/:name/:start_datetime/:end_datetime' do
    start_date = Time.at(params[:start_datetime].to_i)
    end_date = Time.at(params[:end_datetime].to_i)
    fuelings = Fueling.where('EQ_equip_no = ? AND ftk_date > ? AND ftk_date < ?',
                             params[:name],
                             start_date,
                             end_date)
    build_response(fuelings).to_json
  end

  get '/all/:datetime' do
    start_date = Time.at(params[:datetime].to_i)
    fuelings = Fueling.where('ftk_date > ?',
                             start_date)
    build_response(fuelings).to_json
  end

  get '/all/:start_datetime/:end_datetime' do
    start_date = Time.at(params[:start_datetime].to_i)
    end_date = Time.at(params[:end_datetime].to_i)
    fuelings = Fueling.where('ftk_date > ? AND ftk_date < ?',
                             start_date,
                             end_date)
    build_response(fuelings).to_json
  end

  get '/*' do
    404
  end

  error 404 do
    'Error 404. Webpage Not Found.'
  end

  helpers do
    def build_response(fuelings)
      if fuelings.present?
        return { connection_valid: true,
                 error: '',
                 fueling: fuelings
               }
      else
        return { connection_valid: false,
                 error: 'Your query has returned no results. Please contact IT for further assistance.'
               }
      end
    end
  end
end
