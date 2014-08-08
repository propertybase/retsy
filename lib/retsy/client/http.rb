require "faraday"
require "faraday_middleware"
require "faraday/digestauth"
require "faraday/conductivity"
require "faraday-cookie_jar"
require "retsy/middleware/rets_request_id"
require "retsy/middleware/nori_xml"


module Retsy
  class Client
    module Http
      def http
        @http ||= Faraday.new(url: base_url) do |builder|
          builder.request :rets_request_id
          builder.request :user_agent, app: Retsy.to_s, version: Retsy::VERSION
          builder.request :digest, username, password
          builder.request :request_headers, accept: "application/xml"

          builder.response :nori_xml, content_type: /\bxml$/

          builder.use :cookie_jar
          builder.adapter(Faraday.default_adapter)
        end
      end

      def request(path, params = {})
        http.get(path, params.merge(:"rets-version" => "rets/#{@version}"))
      end
    end
  end
end
