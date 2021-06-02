# frozen_string_literal: true

require 'spec_helper'

module DispatcherSpecHelper
  def base_64_encoded_file
    Base64.encode64(
      File.open(
        File.expand_path('../../fixtures/sample.pdf', File.dirname(__FILE__)),
      ).read
    )
  end


  def test_body
    {
      document: {
        path:             '/test/sample.pdf',
        content_base64:   "data:application/pdf;base64,#{base_64_encoded_file}",
        deadline_at:      (SpecHelper.nowish >> 2).strftime('%Y-%m-%dT%H:%M:%S.%L%z'),
        auto_close:       true,
        locale:           'pt-BR',
        sequence_enabled: false
      }
    }
  end
end
