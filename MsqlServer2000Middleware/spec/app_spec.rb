require File.dirname(__FILE__) + '/spec_helper.rb'

describe "My App" do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end

  it "should respond to /vehicle/:id" do
    get '/vehicle/3201'
    assert last_response.body.include?("3201")
  end
  
  it "should respond to /vehicle/:id/:datetime" do
    dateTime = Date.new(2011,12,13).strftime('%s')
    get "/vehicle/3201/#{dateTime}"
    assert last_response.body.include?("3201" && "2011/12/14 19:40:51 -0500")
  end
  
  it "should respond to /vehicle/:id/:start_datetime/:end_datetime" do
    startdateTime = Date.new(2011,11,9).strftime('%s')
    enddateTime = Date.new(2011,12,13).strftime('%s')
    get "/vehicle/3201/#{startdateTime}/#{enddateTime}"
    assert last_response.body.include?("3201")
  end
  
  it "should respond to /all/:datetime" do
    dateTime = Date.new(2011,12,13).strftime('%s')
    get "/all/#{dateTime}"
    assert last_response.body.include?("2011/12/14 19:40:51 -0500")
  end
  
  it "/all/:start_datetime/:end_datetime" do
    startdateTime = Date.new(2011,11,9).strftime('%s')
    enddateTime = Date.new(2011,12,13).strftime('%s')
    get "/all/#{startdateTime}/#{enddateTime}"
    assert last_response.body.include?("2011/12/12")
  end
  
end
