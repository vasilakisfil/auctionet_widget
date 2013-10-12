require 'httparty'
require 'json'
require 'timerizer'
require 'open-uri'

require_relative '../lib/helpers'

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
#


SCHEDULER.every '2s', :first_in => 0 do |job|
  if ENV['testing'] == 'TRUE'
    response = open(ENV['json_link']) { |f| f.read }
  else
    response = open(ENV['json_link']) { |f| f.read }
  end
  #if response.code === 200
    # we suppose that JSON is always parsed correctly
    # covered by auctionet's internal tests..
    json_response = JSON.parse(response)
    results = Hash.new
    results = Helpers::parse_json_data(json_response)
    for num in 0..8 do
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
        })
    end
  #end
end

