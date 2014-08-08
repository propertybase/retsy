require "nori"
require "faraday_middleware/response_middleware"
require "retsy/tools/xml_sanitizer"

module Retsy
  module Middleware
    class NoriXml < FaradayMiddleware::ResponseMiddleware
      define_parser do |body|
        Nori.new.parse(XmlSanitizer.sanitize(body))
      end
    end
  end
end

Faraday::Response.register_middleware(
  nori_xml: Retsy::Middleware::NoriXml
)
