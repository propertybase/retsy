require "spec_helper"

module Retsy
  class Client
    describe Search do
      shared_examples "check result" do
        it "returns the correct result" do
          expect(mocked_client).
            to receive(:request).
            with(mocked_response_arguments[:search], params).
            and_return(mocked_response)
          expect(mocked_client.search(params)).to eq(expected_results)
        end
      end

      describe "#search" do
        include_context "mocked client"

        let(:params) do
          {
            search_type: "Property",
            class: "RES",
            query: "(ListPrice=50000-)",
            querytype: "DMQL2",
          }
        end

        let(:mocked_response) { OpenStruct.new(body: wrapped_metadata) }

        context "3 results" do
          let(:expected_results) { ["listing", "after", "listing"] }

          let(:wrapped_metadata) do
            {
              "ReplyCode" => "0",
              "REData" => expected_results.map do |l|
                {
                  "REProperties" => {
                    params[:class] => l,
                  }
                }
              end
            }
          end

          include_examples "check result"
        end

        context "1 result" do
          let(:expected_results) { ["listing"] }

          let(:wrapped_metadata) do
            {
              "ReplyCode" => "0",
              "REData" => {
                "REProperties" => {
                  params[:class] => expected_results.first,
                }
              }
            }
          end

          include_examples "check result"
        end

        context "no results" do
          let(:expected_results) { [] }

          let(:wrapped_metadata) do
            {
              "ReplyCode" => "20201",
              "ReplyText" => "No Records Found.",
            }
          end

          include_examples "check result"
        end
      end
    end
  end
end
