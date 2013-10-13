require 'httparty'
require 'json'
require 'timerizer'
require 'open-uri'
require_relative '../lib/helpers'

# :first_in sets how long it takes before the job is first run. In this case,
# it is run immediately
#

if !ENV['REFRESH_TIME']
  refresh_time = "1s"
else
  refresh_time = ENV["REFRESH_TIME"]
end

SCHEDULER.every refresh_time, :first_in => 0 do |job|
  response = HTTParty.get("http://auctionet.com/api/v2/items.json?order=bid_on")
  if response.code === 200
    json_response = JSON.parse(response.body)
    results = Hash.new
    results = Helpers::parse_json_data(json_response)
    for num in 0..7 do
      #barsoom style
      send_event(
        "image_#{num}",
        {
          item_id: results[num][:item_id],
          title: results[num][:title],
          image: results[num][:image],
          item_href: results[num][:item_href],
          ends_at: Time.until(results[num][:ends_at]).to_s(:short),
          bid_amount: results[num][:bid_amount],
          bid_time: Time.since(results[num][:bid_time]).to_s(:micro)
        }
      )
    end
  end
end
