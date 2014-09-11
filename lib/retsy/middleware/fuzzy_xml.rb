module Retsy
  module Middleware
    class FuzzyXml < Faraday::Response::Middleware
      def call(env)
        @app.call(env).on_complete do |res|
          content_type = res.response_headers[:content_type]
          unless content_type =~ /\bxml$/ || content_type =~ /^multipart/
            if res.body =~ /^</
              res.response_headers[:content_type] = "application/xml"
            end
          end
        end
      end

      def initialize(app, _options = {})
        super(app)
      end
    end
  end
end

Faraday::Response.register_middleware(
  fuzzy_xml: Retsy::Middleware::FuzzyXml
)
