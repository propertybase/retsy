require "retsy/tools/rets_response_parser"

module Retsy
  module Tools
    describe RetsResponseParser do
      subject { described_class }

      describe "#validate!" do
        context "no results" do
          let(:rets_response) do
            {
              "ReplyCode" => "20201",
              "ReplyText" => "No Records Found.",
            }
          end

          it "raises correct expection" do
            expect{subject.validate!(rets_response)}.
              to raise_error(Retsy::NoRecordsFoundError)
          end
        end
      end
    end
  end
end
