# frozen_string_literal: true

require 'helpers/dispatcher_spec_helper'

RSpec.describe ClicksignRb::Dispatcher do
  include DispatcherSpecHelper

  before(:each) do
    VCR.insert_cassette 'dispatcher', record_on_error: false
  end

  after(:each) do
    VCR.eject_cassette
  end


  let(:dispatcher) { ClicksignRb::Dispatcher.new }

  describe 'post' do
    it 'sends the right request' do
      response = dispatcher.post('/documents', test_body)

      expect(response['document']).not_to be nil
    end

    it 'raises error on failed response' do
      expect do
        dispatcher.post('/NOT_FOUND', test_body)
      end.to raise_error(ClicksignRb::HttpResponseError)
    end
  end
end
