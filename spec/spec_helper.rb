require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "retsy"

Dir["spec/support/**/*.rb"].each { |f| require "./#{f}" }

module EnvCompatibility
  def faraday_env(env)
    if defined?(Faraday::Env)
      Faraday::Env.from(env)
    else
      env
    end
  end
end

module ResponseMiddlewareExampleGroup
  def self.included(base)
    base.let(:options) { Hash.new }
    base.let(:headers) { Hash.new }
    base.let(:middleware) do
      described_class.new(
        lambda { |env| Faraday::Response.new(env) },
        options
      )
    end
  end

  def process(body, content_type = nil, options = {})
    env = {
      body: body, request: options,
      request_headers: Faraday::Utils::Headers.new,
      response_headers: Faraday::Utils::Headers.new(headers)
    }
    env[:response_headers]["content-type"] = content_type if content_type
    yield(env) if block_given?
    middleware.call(faraday_env(env))
  end
end

RSpec.configure do |config|
  config.include EnvCompatibility, type: :middleware
  config.include ResponseMiddlewareExampleGroup, type: :middleware
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
