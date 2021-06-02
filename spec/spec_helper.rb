# frozen_string_literal: true

require 'webmock/rspec'
require 'vcr'


require 'clicksign_rb'


module SpecHelper
  def self.nowish
    @nowish ||= DateTime.parse '2021-06-01T22:18:25-03:00'
  end
end


VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock

  config.default_cassette_options = {
    record: :once,
    match_requests_on: [:body,:query, :uri, :method]
  }

  config.filter_sensitive_data('<ACCESS_TOKEN>') { ENV.fetch 'TOKEN' }

  if ENV['INTEGRATION_TEST'] == '1' then
    config.ignore_request do |request|
      true
    end
  end
end


ClicksignRb.configure do |config|
  config.host = 'https://sandbox.clicksign.com/api'
  config.token = ENV.fetch 'TOKEN'

  config.logger_options.out = '/dev/null'
end


RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
