require "spec_helper"

module Retsy
  class Client
    describe Object do
      describe "#object" do
        include_context "mocked client"

        subject { mocked_client }

        let(:params) do
          {
            resource: "Property",
            type: "Photo",
            id: "361574:*",
            location: 0
          }
        end

        let(:parsed_response) do
          [
            {
              headers: {
                "Content-Transfer-Encoding" => "binary",
                "Content-ID" => "361574",
                "Object-ID" => "1",
                "Content-Type" => "image/jpeg",
                "Content-Length" => "126559",
              },
              body: "BINARY",
            },
            {
              headers: {
                "Content-Transfer-Encoding" => "binary",
                "Content-ID" => "361574",
                "Object-ID" => "2",
                "Content-Type" => "image/jpeg",
                "Content-Length" => "36695",
              },
              body: "BINARY",
            },
          ]
        end

        let(:http_response) { OpenStruct.new(body: double("MultipartBody")) }

        before(:each) do
          allow(subject).
            to receive(:request).
            and_return(http_response)
          allow(MultipartParser).
            to receive(:parse).
            with(http_response).
            and_return(parsed_response)
        end

        it "sends correct messages" do
          expect(subject.object(params)).to eq(parsed_response)
        end
      end
    end
  end
end
