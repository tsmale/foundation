require_relative '../app.rb'
require 'rspec'
require 'rack/test'

set :environment, :test

describe 'App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "should list the actors for a given film" do
    get '/?film=Top_Gun'
    expect(last_response.body).to eq('{"actors":["Tom_Cruise","Val_Kilmer","Tom_Skerritt","Anthony_Edwards","Kelly_McGillis"]}')
  end

  it "should list the films starring a given actor" do
    get '/?actor=Henry_Cavill'
    expect(last_response.body).to eq('{"films":["Man_of_Steel_(film)","Justice_League_(film)","The_Cold_Light_of_Day_(2012_film)","The_Man_from_U.N.C.L.E._(film)","Immortals_(2011_film)","Red_Riding_Hood_(2006_film)","I_Capture_the_Castle_(film)","Blood_Creek","Batman_v_Superman:_Dawn_of_Justice","Sand_Castle_(film)","Hellraiser:_Hellworld"]}')
  end

  it "should not list TV shows along with films" do
    get '/?actor=Macaulay_Culkin'
    expect(last_response.body).not_to include("Wish_Kid")
  end

  it "should not make a request if the search is invalid" do
    get '/?author=Isaac_Asimov'
    expect(last_response.body).to eq('Invalid search type, expected "film" or "actor"')
  end
end
