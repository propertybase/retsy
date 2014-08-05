require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "retsy"

Dir["spec/support/**/*.rb"].each {|f| require "./#{f}"}
