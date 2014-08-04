module Retsy
  class Client
    class RetsRequestId < Faraday::Middleware

      def initialize(app)
        super(app)
      end

      def call(env)
        env[:request_headers]['RETS-Request-Id'] ||= SecureRandom.hex(32)
        @app.call(env)
      end

    end
  end
end

Faraday::Request.register_middleware(
  rets_request_id: Retsy::Client::RetsRequestId
)
