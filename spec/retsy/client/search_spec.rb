require "spec_helper"

module Retsy
  class Client
    describe Search do
      describe "#search" do
        include_context "mocked client"
        let(:params) do
          {
            search_type: "Property",
            class: "RES",
            query: "(ListPrice=50000-)",
          }
        end

        let(:mocked_response) { OpenStruct.new(body: expected_results) }
        let(:expected_results) { ["listing", "after", "listing"] }

        it "sends the correct messages" do
          expect(mocked_client).
            to receive(:request).
            with(mocked_response_arguments[:search], params).
            and_return(mocked_response)
          expect(mocked_client.search(params)).to eq(expected_results)
        end
      end
    end
  end
end
