require "spec_helper"

module Retsy
  class Client
    describe Count do
      describe "#count" do
        include_context "mocked client"

        let(:mocked_response) do
          OpenStruct.new(
            body: body
          )
        end

        let(:params) do
          {
            search_type: "Property",
            class: "RES",
            query: "(ListPrice=50000-)",
            count: 2,
          }
        end

        before(:each) do
          allow(subject).
            to receive(:request).
            with(mocked_response_arguments[:search], params).
            and_return(mocked_response)
        end

        subject { mocked_client }

        context "records available" do
          let(:body) do
            {
              "COUNT" => { "Records"=>"#{expected_count}" },
              "ReplyCode"=>"0",
              "ReplyText"=>"Operation Successful"
            }
          end

          let(:expected_count) { 2611 }

          it "sends the correct messages" do
            expect(subject.count(params)).to eq(expected_count)
          end
        end

        context "no records available" do
          let(:body) do
            {
              "ReplyCode"=>"20201",
              "ReplyText"=>"No Records Found."
            }
          end

          let(:expected_count) { 0 }

          it "sends the correct messages" do
            expect(subject.count(params)).to eq(expected_count)
          end
        end

        context "invalid query" do
          let(:body) do
            {
              "RETS-STATUS"=>{
                "ReplyCode"=>"20201",
                "ReplyText"=>"No matching records were found"
              },
              "ReplyCode"=>"0",
              "ReplyText"=>"Operation Successful"
            }
          end

          let(:expected_count) { 0 }

          it "sends the correct messages" do
            expect(subject.count(params)).to eq(expected_count)
          end
        end
      end
    end
  end
end
