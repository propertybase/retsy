source 'https://rubygems.org'

# Specify your gem's dependencies in retsy.gemspec
gemspec

gem "codeclimate-test-reporter", group: :test, require: nil

group :test, :development do
  gem "guard"
  gem "guard-rspec"

  gem "rb-inotify", require: false
  gem "rb-fsevent", require: false
  gem "rb-fchange", require: false
end
