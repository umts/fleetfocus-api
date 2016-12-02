class EAMApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    set :root, File.join(File.dirname(settings.app_file), '..')
    access_log = File.new("#{settings.root}/log/#{settings.environment}_access.log", 'a+')
    error_log = File.new("#{settings.root}/log/#{settings.environment}_error.log", 'a+')
    access_log.sync = true
    error_log.sync = true
    set :access_log, access_log
    set :error_log, error_log

    enable :logging
    use Rack::CommonLogger, settings.access_log
  end

  before do
    env["rack.errors"] = settings.error_log
    content_type :json
  end

  after do
    response.body = build_response(@fuelings).to_json
  end

  get '/vehicle/:name' do
    @fuelings = Fueling.where('EQ_equip_no = ?', params[:name])
  end

  get '/vehicle/:name/:datetime' do
    start_date = Time.at(params[:datetime].to_i)
    @fuelings = Fueling.where('EQ_equip_no = ? AND ftk_date > ?', params[:name], start_date)
  end

  get '/vehicle/:name/:start_datetime/:end_datetime' do
    start_date = Time.at(params[:start_datetime].to_i)
    end_date = Time.at(params[:end_datetime].to_i)
    @fuelings = Fueling.where('EQ_equip_no = ? AND ftk_date > ? AND ftk_date < ?',
                              params[:name], start_date, end_date)
  end

  get '/all/:datetime' do
    start_date = Time.at(params[:datetime].to_i)
    @fuelings = Fueling.where('ftk_date > ?', start_date)
  end

  get '/all/:start_datetime/:end_datetime' do
    start_date = Time.at(params[:start_datetime].to_i)
    end_date = Time.at(params[:end_datetime].to_i)
    @fuelings = Fueling.where('ftk_date > ? AND ftk_date < ?', start_date, end_date)
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
        return { connection_valid: true, error: '', fueling: fuelings.as_json(except: 'row_id') }
      else
        return { connection_valid: false,
                 error: 'Your query has returned no results. Please contact IT for further assistance.'
               }
      end
    end
  end
end
