require "spec_helper"

module Retsy
  class Client
    describe Http do
      describe "#http" do
        include_context "mocked client"
        let(:connection) { mocked_client.http }
        let(:expected_handlers) do
          [
            Retsy::Middleware::RetsRequestId,
            Faraday::Conductivity::UserAgent,
            Faraday::Request::DigestAuth,
            Faraday::Conductivity::RequestHeaders,
            Retsy::Middleware::SaxXml,
            Retsy::Middleware::FuzzyXml,
            Faraday::CookieJar,
            Faraday::Adapter::NetHttp,
          ]
        end

        it "initializes a faraday connection" do
          expect(connection).to be_a(Faraday::Connection)
        end

        it "has all necessary handlers" do
          expect(connection.builder.handlers).to eq(expected_handlers)
        end
      end
    end
  end
end
