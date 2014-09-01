require "spec_helper"
require "ostruct"

module Retsy
  class Client
    describe Metadata do
      describe "#metadata" do
        include_context "mocked client"
        subject { mocked_client }

        let(:mocked_response) { OpenStruct.new(body: wrapped_metadata) }
        let(:wrapped_metadata) do
          {
            "METADATA" => {
              "METADATA-TABLE" => expected_metadata
            }
          }
        end

        let(:expected_metadata) { { meta: :data } }
        let(:params) { { type: "METADATA-TABLE", id: "Property" } }

        it "sends the correct messages" do
          expect(subject).
            to receive(:request).
            with(mocked_response_arguments[:get_metadata], params).
            and_return(mocked_response)
          expect(subject.metadata(params)).to eq(expected_metadata)
        end
      end
    end
  end
end
