require 'timerizer'
require 'date'

module Helpers
  def Helpers.parse_json_data(json_response)
    app_link = "http://auctionet.com"
    results = Hash.new
    for num in 0..8 do
      result = Hash.new
      result[:item_id] = json_response["items"][num]["id"]
      result[:title] = json_response["items"][num]["title"]
      result[:image] = json_response["items"][num]["images"][0]["mini"]
      # not documented but I guess it is a custom route
      result[:item_href] = "#{app_link}/#{result[:item_id]}"
      ends_at_epoch = json_response["items"][num]["ends_at"]
      result[:ends_at] = Time.at(ends_at_epoch)
      result[:bid_amount] = json_response["items"][num]["bids"][0]["amount"]
      bid_epoch_time =  json_response["items"][num]["bids"][0]["timestamp"]
      result[:bid_time] = Time.at(bid_epoch_time)
      results[num] = result
    end
    results
  end
end
