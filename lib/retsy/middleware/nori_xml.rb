require "saxerator"
require "faraday_middleware/response_middleware"
require "retsy/tools/xml_sanitizer"

module Retsy
  module Middleware
    class NoriXml < FaradayMiddleware::ResponseMiddleware
      define_parser do |body|
        Saxerator.parser(XmlSanitizer.sanitize(body)) do |config|
          config.put_attributes_in_hash!
        end.all
      end
    end
  end
end

Faraday::Response.register_middleware(
  nori_xml: Retsy::Middleware::NoriXml
)
