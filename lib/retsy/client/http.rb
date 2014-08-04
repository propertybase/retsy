require "faraday"
require "faraday_middleware"
require "faraday/digestauth"
require "faraday/conductivity"
require "retsy/client/rets_request_id"


module Retsy
  class Client
    module Http
      def http
        @http ||= Faraday.new(url: base_url) do |builder|
          builder.response :xml,  :content_type => /\bxml$/
          builder.response :json, :content_type => /\bjson$/

          builder.request :rets_request_id
          builder.request :user_agent, app: Retsy.to_s, version: Retsy::VERSION
          builder.request(:digest, username, password)
          builder.adapter(Faraday.default_adapter)
        end
      end
    end
  end
end
