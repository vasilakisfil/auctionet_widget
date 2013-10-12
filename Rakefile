require 'rake'
require 'rspec/core/rake_task'


task :spec do
  puts "Run tests run!"
  ENV['testing'] = 'TRUE'
  ENV['json_link'] = 'spec/test_data.json'
  `dashing start &`
  `rspec spec/acceptance_spec.rb`
end
#RSpec::Core::RakeTask.new(:spec)

task :run do
  ENV['testing'] = 'FALSE'
  ENV['json_link'] = 'http://auctionet.com/api/v2/items.json?order=bid_on'
  `dashing start`
end


