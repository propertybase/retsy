require "spec_helper"

module Retsy
  class Client
    describe Http do
      describe "#http" do
        include_context "mocked client"
        let(:connection) { mocked_client.http }
        let(:expected_handlers) do
          [
            FaradayMiddleware::ParseXml,
            Retsy::Client::RetsRequestId,
            Faraday::Conductivity::UserAgent,
            Faraday::Request::DigestAuth,
            Faraday::CookieJar,
          ]
        end

        it "initializes a faraday connection" do
          expect(connection).to be_a(Faraday::Connection)
        end

        it "has all necessary handlers" do
          expected_handlers.each do |handler|
            expect(connection.builder.handlers).to include(handler)
          end
        end
      end
    end
  end
end
