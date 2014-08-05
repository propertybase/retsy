require "faraday"
require "faraday_middleware"
require "faraday/digestauth"
require "faraday/conductivity"
require "faraday-cookie_jar"
require "retsy/client/rets_request_id"


module Retsy
  class Client
    module Http
      def http
        @http ||= Faraday.new(url: base_url) do |builder|
          builder.response :xml,  :content_type => /\bxml$/

          builder.request :rets_request_id
          builder.request :user_agent, app: Retsy.to_s, version: Retsy::VERSION
          builder.request(:digest, username, password)
          builder.use :cookie_jar
          builder.adapter(Faraday.default_adapter)
        end
      end
    end
  end
end
