require "spec_helper"
require "retsy/middleware/sax_xml"

module Retsy
  module Middleware
    describe SaxXml, type: :middleware do
      context "valid XML" do
        let(:xml) { "<root><tag>content</tag></root>" }
        let(:expected_result) { { "tag" => "content" } }

        it "parses XML to hash" do
          expect(process(xml).body).to eq(expected_result)
        end
      end

      context "invalid XML" do
        let(:xml) { "<root><tag>invalid&#19;</tag></root>" }
        let(:expected_result) { { "tag" => "invalid " } }

        it "parses XML to hash" do
          expect(process(xml).body).to eq(expected_result)
        end
      end
    end
  end
end
