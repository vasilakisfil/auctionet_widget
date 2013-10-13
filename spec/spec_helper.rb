require_relative '../lib/helpers'

require 'rspec'
require 'capybara'
require 'capybara/rspec'


RSpec.configure do |config|
  config.include Capybara::DSL
end

