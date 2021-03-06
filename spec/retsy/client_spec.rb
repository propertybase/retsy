require "spec_helper"

module Retsy
  describe Client do
    describe "initializing" do
      subject { described_class.new(options) }
      let(:options) { { key => value } }

      context "defined settings" do
        let(:key) { :login_url }
        let(:value) { "http://example.de" }

        it "sets the settings to instance variables" do
          expect(subject.instance_variable_get("@#{key}")).to eq(value)
        end
      end

      context "non-defined setttings" do
        let(:key) { :fluffy_key }
        let(:value) { "something not nil" }

        it "does not set the setting" do
          expect(subject.instance_variable_get("@#{key}")).to eq(nil)
        end
      end
    end

    describe "#base_url" do
      subject { described_class.new(login_url: "http://propertybase.com/foo") }
      it "builds base_url correctly" do
        expect(subject.base_url).to eq("http://propertybase.com")
      end
    end
  end
end
