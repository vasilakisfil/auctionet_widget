require 'spec_helper'
require 'json'
require 'httparty'
require_relative '../lib/helpers'

Capybara.app_host = 'http://127.0.0.1:3030'
Capybara.current_driver = :selenium

data = File.read("spec/test_data.json")
json_data = JSON.parse(data)
results = Hash.new
results = Helpers::parse_json_data(json_data)


for num in 0..7 do
  results[num][:auth_token] = "YOUR_AUTH_TOKEN"
  HTTParty.post("http://localhost:3030/widgets/image_#{num}", :body => results[num].to_json)
end

describe "Dashboards" do
  it "should have the widgets" do
    visit '/ops'
    puts page
    expect(page).to have_content("Time left")
    expect(page).to have_content("Last bid")
    end
=begin
  describe "Widgets" do
    it "shou
    expect(true).to be true
  end
=end
end
