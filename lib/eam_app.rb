# frozen_string_literal: true

require 'app_logs'
require 'exception_notifier/umts_notifier'

class EAMApp < Sinatra::Base
  register AppLogs
  register Sinatra::ActiveRecordExtension
  use ExceptionNotification::Rack, umts: { env: settings.environment }

  configure do
    set :root, File.join(File.dirname(settings.app_file), '..')
  end

  after do
    if @fuelings.present?
      response.body = jbuilder :fueling
    else
      response.status = 404
    end
  end

  get '/vehicle/:name' do
    @fuelings = Fueling.where(EQ_equip_no: params[:name])
                       .order('ftk_date DESC')
  end

  get '/vehicle/:name/:datetime' do
    start_date = Time.at(params[:datetime].to_i)
    @fuelings = Fueling.where('EQ_equip_no = ? AND ftk_date > ?',
                              params[:name], start_date)
                       .order('ftk_date DESC')
  end

  get '/vehicle/:name/:start_datetime/:end_datetime' do
    start_date = Time.at(params[:start_datetime].to_i)
    end_date = Time.at(params[:end_datetime].to_i)
    @fuelings =
      Fueling.where('EQ_equip_no = ? AND ftk_date > ? AND ftk_date < ?',
                    params[:name], start_date, end_date)
             .order('ftk_date DESC')
  end

  get '/all/:datetime' do
    start_date = Time.at(params[:datetime].to_i)
    @fuelings = Fueling.where('ftk_date > ?', start_date)
                       .order('ftk_date DESC')
  end

  get '/all/:start_datetime/:end_datetime' do
    start_date = Time.at(params[:start_datetime].to_i)
    end_date = Time.at(params[:end_datetime].to_i)
    @fuelings = Fueling.where('ftk_date > ? AND ftk_date < ?',
                              start_date, end_date)
                       .order('ftk_date DESC')
  end

  get '/*' do
    404
  end

  error 404 do
    content_type :json
    { connection_valid: false, error: 'No results' }.to_json
  end
end
