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
    get '/vehicle/3201/2011-12-14'
    assert last_response.body.include?("3201" && "2011-12-14")
  end
  
  it "should respond to /all/:datetime" do
    get '/all/2011-12-14'
    assert last_response.body.include?("2011-12-14")
  end
  
  it "/all/:start_datetime/:end_datetime" do
    get '/all/2011-12-12/2011-12-14'
    assert last_response.body.include?("2011-12-12" && "2011-12-14")
  end
  
end

# Need to test that the dates provided meet the required syntax and if not then the search exits gracefully
