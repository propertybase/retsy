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

        let(:mocked_response) { OpenStruct.new(body: body) }

        context "3 results" do
          let(:expected_results) do
            [
              {
                "ListingID" => "313009",
                "ListPrice" => "1600",
              },
              {
                "ListingID" => "313010",
                "ListPrice" => "1700",
              },
              {
                "ListingID" => "313011",
                "ListPrice" => "1800",
              },
            ]
          end

          let(:body) do
            {
              "ReplyCode" => "0",
              "DELIMITER" => { "value"=>"09" } ,
              "COLUMNS" => "\tListingID\tListPrice\t",
              "DATA" => [
                "\t313009\t1600\t",
                "\t313010\t1700\t",
                "\t313011\t1800\t"
              ],
            }
          end

          include_examples "check result"
        end

        context "1 result" do
          let(:expected_results) do
            [
              {
                "ListingID" => "313009",
                "ListPrice" => "1600",
              }
            ]
          end

          let(:body) do
            {
              "ReplyCode" => "0",
              "DELIMITER" => { "value"=>"09" },
              "COLUMNS" => "\tListingID\tListPrice\t",
              "DATA" => "\t313009\t1600\t",
            }
          end

          include_examples "check result"
        end

        context "no results" do
          let(:expected_results) { [] }

          let(:body) do
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
