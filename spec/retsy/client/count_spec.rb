require "spec_helper"

module Retsy
  class Client
    describe Count do
      describe "#count" do
        include_context "mocked client"
        subject { mocked_client }

        let(:xml_response) do
          "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>" \
          "\r\n<RETS ReplyCode=\"0\" ReplyText=\"Operation Successful\">" \
          "\r\n<COUNT Records=\"#{expected_count}\" />" \
          "\r\n</RETS>"
        end

        let(:mocked_response) do
          OpenStruct.new(
            body: Retsy::Middleware::SaxXml.parser.call(xml_response)
          )
        end

        let(:expected_count) { 2611 }
        let(:params) do
          {
            search_type: "Property",
            class: "RES",
            query_type: "DMQL2",
            query: "(ListPrice=50000-)",
            count: 2,
          }
        end

        it "sends the correct messages" do
          expect(subject).
            to receive(:request).
            with(mocked_response_arguments[:search], params).
            and_return(mocked_response)
          expect(subject.count(params)).to eq(expected_count)
        end
      end
    end
  end
end
