require 'spec_helper'
require 'date'
require 'json'
require 'rspec'

describe Helpers do
=begin
  class DummyClass
  end

  before(:each) do
    @helper = DummyClass.new
    @helper.extend(Helpers)
  end
=end
  describe ".parseJSON" do
    context "with valid json" do
      it "returns valid data" do
        app_link = "http://auctionet.com"
        response = File.read("spec/test_data.json")
        json_data = JSON.parse(response)
        results = Hash.new
        results = Helpers::parse_json_data(json_data)
        for num in 0..8 do
          expect(results[num][:item_id]).to eq(num)
          expect(results[num][:title]).to eq("title#{num}")
          expect(results[num][:image]).to eq("image#{num}.JPG")
          expect(results[num][:item_href]).to eq("#{app_link}/#{results[num][:item_id]}")
          expect(results[num][:ends_at]).to eq(Time.at(num))
          expect(results[num][:bid_amount]).to equal(num*100)
          expect(results[num][:bid_time]).to eq(Time.at(num))
        end
      end
    end
  end
end
