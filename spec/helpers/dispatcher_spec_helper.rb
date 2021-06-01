#!/usr/bin/env ruby
#
# dispatcher_spec_helper.rb
# Copyright (C) 2021 otto <otto@otto-Aspire-5750>
#
# Distributed under terms of the MIT license.
#



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
        path:             '/teste.pdf',
        content_base64:   'data:application/pdf;base64,#{base_64_encoded_file}',
        deadline_at:      (DateTime.now >> 2).strftime('%Y-%m-%dT%H:%M:%S.%L%z'),
        auto_close:       true,
        locale:           'pt-BR',
        sequence_enabled: false
      }
    }
  end
end
