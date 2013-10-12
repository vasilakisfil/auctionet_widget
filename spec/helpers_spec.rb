require 'spec_helper'
require 'httparty'
require 'json'
require 'rspec'

describe Helpers do

  class DummyClass
  end

  before(:each) do
    @helper = DummyClass.new
    @helper.extend(Helpers)
  end

  describe ".parseJSON" do
    context "with valid json" do
      it "returns valid data" do
        response = HTTParty.get('http://auctionet.com/api/v2/items.json?order=bid_on')
        json_data = JSON.parse(response.body)
        results = Hash.new
        results = @helper.parse_json_data(json_data)
        puts results[0]
        for num in 0..8 do
          expect(results[num][:item_id]).to be_a(Integer)
          expect(results[num][:title]).to be_a(String)
          expect(results[num][:image]).to match(/http(s?):\/\/([\w]+\.){1}([\w]+\.?)+/)
          expect(
        end
      end
    end
  end
end
