require "spec_helper"
require "retsy/tools/xml_sanitizer"

module Retsy
  describe XmlSanitizer do
    subject { described_class }

    context "valid XML" do
      let(:xml) { "<tag>everything's fine</tag>" }
      let(:replaced_xml) { "<tag>everything's fine</tag>" }

      it "does not replace anyting" do
        expect(subject.sanitize(xml)).to eq(replaced_xml)
      end
    end

    context "invalid XML" do
      (0..31).each do |number|
        context "invalid character ##{number}" do
          let(:xml) { "<tag>bad: &##{number};</tag>" }
          let(:replaced_xml) { "<tag>bad:  </tag>" }

          it "replaces invalid character" do
            expect(subject.sanitize(xml)).to eq(replaced_xml)
          end
        end
      end
    end
  end
end
