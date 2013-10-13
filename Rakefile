require 'rake'
require 'rspec/core/rake_task'


task :test_server do
  puts "Setting servers for tests"
  ENV['json_link'] = 'spec/test_data.json'
  `dashing start`
end

RSpec::Core::RakeTask.new(:spec)

task :run do
  `dashing start`
end


