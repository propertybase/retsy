require "spec_helper"

module Retsy
  module Tools
    describe ResponseArgumentsParser do
      subject { described_class }
      let(:rets_response) do
        "\r\nMemberName=Some Company" \
        "\r\nUser=xxxxRETS  718,0,idx2014,xxxxRETS  718" \
        "\r\nBroker=0,0\r\nMetadataVersion=01.01.00000" \
        "\r\nMetadataTimestamp=2014-03-27T13:06:52" \
        "\r\nMinMetadataTimestamp=2014-03-27T13:06:52" \
        "\r\nTimeoutSeconds=1800\r\nGetObject=/rets/GetObject" \
        "\r\nLogin=/rets/Login\r\nLogout=/rets/Logout\r\nSearch=/rets/Search" \
        "\r\nGetMetadata=/rets/GetMetadata\r\n"
      end

      describe "#parse" do
        context "correct response" do
          let(:expected_response) do
            {
              member_name: "Some Company",
              user: "xxxxRETS  718,0,idx2014,xxxxRETS  718",
              broker: "0,0",
              metadata_version: "01.01.00000",
              metadata_timestamp: "2014-03-27T13:06:52",
              min_metadata_timestamp: "2014-03-27T13:06:52",
              timeout_seconds: "1800",
              get_object: "/rets/GetObject",
              login: "/rets/Login",
              logout: "/rets/Logout",
              search: "/rets/Search",
              get_metadata: "/rets/GetMetadata",
            }
          end

          it "parses rets response correctly" do
            expect(subject.parse(rets_response)).to eq(expected_response)
          end
        end
      end
    end
  end
end
