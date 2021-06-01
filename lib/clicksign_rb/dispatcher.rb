# frozen_string_literal: true

require 'httparty'

module ClicksignRb
  class DispatcherError < Error
    attr_reader :original_error


    def initialize(message=nil, original_error: nil)
      @original_error = original_error
      super(message)
    end
  end


  class HttpResponseError < DispatcherError
    attr_reader :code

    def initialize(code)
      @code = code
      super("Request to ClickSign failed with code #{code}")
    end
  end


  class Dispatcher
    def initialize(
      host:        Config.host,
      api_version: Config.api_version,
      token:       Config.token,
      logger:      Config.logger,
      http_debug:  Config.http_debug
    )
      @host        = host
      @api_version = api_version
      @token       = token
      @logger      = logger
      @http_debug  = http_debug
    end


    def post(endpoint, body)
      response = HTTParty.post(
        "#{@host}/#{@api_version}#{endpoint}",
        query: {
          access_token: @token,
          },
        body: body,
        logger:       @logger,
        debug_output: @http_debug
      )

      return JSON.parse(response.body) if response.success?

      raise HttpResponseError.new(response.code)
    rescue DispatcherError => error
      @logger.error "Error while talking to ClickSign. #{error}"

      raise
    rescue StandardError => error
      @logger.error "Error while talking to ClickSign. #{error}"

      raise DispatcherError.new(
        'Comunication with ClickSign failed.',
        original_error: error
      )
    end
  end
end
