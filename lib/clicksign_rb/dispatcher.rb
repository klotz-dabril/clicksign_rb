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
    attr_reader :code, :response

    def initialize(code, response)
      @code = code
      @response = response

      super(
        "Request to ClickSign failed with code #{code}"\
        " and errors #{response['errors']}"
      )
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

      @headers = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    end


    def post(endpoint, body)
      raw_response = HTTParty.post(
        "#{@host}/#{@api_version}#{endpoint}",
        headers:      @headers,
        body:         JSON.generate(body),
        logger:       @logger,
        debug_output: @http_debug,

        query: {
          access_token: @token,
        }
      )

      response = raw_response.to_h

      return response if raw_response.success?

      raise HttpResponseError.new(raw_response.code, response)
    rescue DispatcherError => error
      raise
    rescue StandardError => error
      raise DispatcherError.new(
        'Comunication with ClickSign failed.',
        original_error: error
      )
    end
  end
end
