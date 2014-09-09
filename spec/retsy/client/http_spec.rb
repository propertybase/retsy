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

      describe "#request" do
        include_context "mocked client"
        subject { mocked_client }

        let(:path) { "/search" }
        let(:version) { "1.8" }
        let(:expected_parameters) do
          {
            :"rets-version" => "rets/#{version}",
            querytype: "DMQL2",
            format: "COMPACT-DECODED"
          }
        end

        before(:each) do
          subject.instance_variable_set("@version", version)
        end

        it "merges correct parameters" do
          expect(subject.http).to receive(:get).with(path, expected_parameters)
          subject.request(path, {})
        end
      end
    end
  end
end
