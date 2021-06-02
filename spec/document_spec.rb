# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ClicksignRb::Document do
  before(:each) do
    VCR.insert_cassette 'document'
  end

  after(:each) do
    VCR.eject_cassette
  end


  describe 'creation of document through upload' do
    context 'with optional parameters' do
      options = {
        file: File.expand_path('../fixtures/sample.pdf', File.dirname(__FILE__)),
        path: '/tests/sample.pdf',
        deadline_at: (SpecHelper.nowish >> 2).strftime('%Y-%m-%dT%H:%M:%S.%L%z'),
        auto_close: false,
        locale: 'en-US',
        sequence_enabled: true,
        remind_interval: 1
      }

      let(:document) { ClicksignRb::Document.create_through_upload(**options)['document'] }

      it "has the right path" do
        expect(document['path']).to eq(options[:path])
      end


      it "has the right auto_close value" do
        expect(document['auto_close']).to eq(options[:auto_close])
      end


      it "has the right locale" do
        expect(document['locale']).to eq(options[:locale])
      end


      it "has the right sequence_enabled value" do
        expect(document['sequence_enabled']).to eq(options[:sequence_enabled])
      end


      it "has the right remind_interval value" do
        expect(document['remind_interval']).to eq(options[:remind_interval])
      end
    end

    context 'with default parameters' do
      options = {
        file: File.expand_path('../fixtures/sample.pdf', File.dirname(__FILE__)),
        path: '/tests/sample.pdf',
      }

      let(:document) { ClicksignRb::Document.create_through_upload(**options)['document'] }

      it "has the right path" do
        expect(document['path']).to eq(options[:path])
      end


      it "has the right auto_close value" do
        expect(document['auto_close']).to be true
      end


      it "has the right locale" do
        expect(document['locale']).to eq("pt-BR")
      end


      it "has the right sequence_enabled value" do
        expect(document['sequence_enabled']).to be false
      end


      it "has the right remind_interval value" do
        expect(document['remind_interval']).to be nil
      end
    end
  end
end
