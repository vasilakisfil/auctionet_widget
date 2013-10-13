require 'rake'
require 'rspec/core/rake_task'


task :test_run do
  puts "Test server for running the tests!"
  puts "Wait ~2sec for the server to start before firing up the tests"
  ENV['REFRESH_TIME'] = '100s'
  `dashing start`
end

RSpec::Core::RakeTask.new(:spec)

task :run do
  puts "Listening on 0.0.0.0:3030"
  `dashing start`
end
