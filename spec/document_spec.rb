# frozen_string_literal: true


RSpec.describe ClicksignRb::Document do
  before(:each) do
    VCR.insert_cassette 'document'
  end

  after(:each) do
    VCR.eject_cassette
  end


  it 'creates a document through upload' do
    expect(ClicksignRb::Document.create_through_upload(
      file: File.expand_path('../fixtures/sample.pdf', File.dirname(__FILE__)),
      path: '/tests/sample.pdf',
      deadline_at: (DateTime.now >> 2).strftime('%Y-%m-%dT%H:%M:%S.%L%z'),
    )['document']).not_to be nil
  end
end
