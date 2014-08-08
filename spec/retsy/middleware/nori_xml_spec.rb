require "spec_helper"
require "retsy/middleware/nori_xml"

module Retsy
  module Middleware
    describe NoriXml, type: :middleware do
      context  "valid XML" do
        let(:xml) { "<tag>content</tag>" }
        let(:expected_result) { { "tag" => "content" } }

        it "parses XML to hash" do
          expect(process(xml).body).to eq(expected_result)
        end
      end

      context "invalid XML" do
        let(:xml) { "<tag>invalid&#19;</tag>" }
        let(:expected_result) { { "tag" => "invalid " } }

        it "parses XML to hash" do
          expect(process(xml).body).to eq(expected_result)
        end
      end
    end
  end
end
