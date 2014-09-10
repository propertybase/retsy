require "spec_helper"
require "ostruct"

module Retsy
  class Client
    describe Metadata do
      describe "#metadata" do
        include_context "mocked client"
        subject { mocked_client }

        let(:mocked_response) { OpenStruct.new(body: wrapped_metadata) }

        let(:expected_metadata) { { meta: :data } }
        let(:params) { { type: "METADATA-TABLE", id: "Property" } }

        before(:each) do
          allow(subject).
            to receive(:request).
            with(mocked_response_arguments[:get_metadata], params).
            and_return(mocked_response)
        end

        context "wrapped in METADATA tag" do
          let(:wrapped_metadata) do
            {
              "METADATA" => {
                "METADATA-TABLE" => expected_metadata
              }
            }
          end

          it "returns correct metadata" do
            expect(subject.metadata(params)).to eq(expected_metadata)
          end
        end

        context "directly nested" do
          let(:wrapped_metadata) do
            {
              "METADATA-TABLE" => expected_metadata
            }
          end

          it "returns correct metadata" do
            expect(subject.metadata(params)).to eq(expected_metadata)
          end
        end
      end
    end
  end
end
