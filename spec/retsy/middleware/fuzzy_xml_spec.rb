require "spec_helper"
require "retsy/middleware/fuzzy_xml"

module Retsy
  module Middleware
    describe FuzzyXml, type: :middleware do
      let(:body) do
        '<RETS ReplyCode="0" ReplyText="Login Request">' \
          "<RETS-RESPONSE>" \
          "</RETS-RESPONSE>" \
        "<RETS>"
      end

      context "XML content with xml content type" do
        let(:content_type) { "application/xml" }
        let(:expected_content_type) { "application/xml" }

        it "leaves content for correct response" do
          expect(process(body, content_type).headers[:content_type]).
            to eq(expected_content_type)
        end
      end

      context "XML content with text/plain content type" do
        let(:content_type) { "text/plain" }
        let(:expected_content_type) { "application/xml" }

      it "leaves content for correct response" do
          expect(process(body, content_type).headers[:content_type]).
            to eq(expected_content_type)
        end
      end
    end
  end
end
