require 'spec_helper'
require 'json'
require 'httparty'
require_relative '../lib/helpers'



describe "Dashboards" do
  before(:each) do
    Capybara.app_host = 'http://127.0.0.1:3030'
    Capybara.current_driver = :selenium

    data = File.read("spec/test_data.json")
    json_data = JSON.parse(data)
    @results = Hash.new
    @results = Helpers::parse_json_data(json_data)

    for num in 0..7 do
      @results[num][:auth_token] = "YOUR_AUTH_TOKEN"
      #barsoom style
      HTTParty.post(
        "http://localhost:3030/widgets/image_#{num}",
        :body => @results[num].to_json
      )
    end
  end

  it "should have the widgets content" do
    visit '/ops'
    within(:xpath, "//div[@id='image_0']") do
      expect(page).to have_content("Time left")
      expect(page).to have_content("Last bid")
      expect(find(:xpath, "./table/caption")).to have_content(@results[0][:title])
      expect(find(:xpath, "./a")).to have_content(@results[0][:item_id])
    end
  end
end
