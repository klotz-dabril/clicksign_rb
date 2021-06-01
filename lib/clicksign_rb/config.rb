# frozen_string_literal: true

require 'logger'
require 'clicksign_rb/application_logger'


LoggerOptions = Struct.new(
  :out, :level, :progname, :formatter, :http_debug, keyword_init: true
)


module ClicksignRb
  module Config
    REQUIRED_ATTRIBUTES = [:host, :token]
    OPTIONAL_ATTRIBUTES = {
      api_version: 'v1',

      logger:         nil,
      logger_options: LoggerOptions.new
    }


    REQUIRED_ATTRIBUTES.each do |attr|
      self.singleton_class.attr_writer attr

      self.singleton_class.define_method attr do
        unless instance_variable_defined? "@#{attr}"
          raise Error.new "Configuration attribute '#{attr}' not defined."
        end

        instance_variable_get "@#{attr}"
      end
    end


    OPTIONAL_ATTRIBUTES.each do |attr, value|
      self.singleton_class.attr_accessor attr

      instance_variable_set "@#{attr}", value
    end


    class << self
      def configure
        yield self
      end


      def logger
        @logger ||= ApplicationLogger.new(logger_options)
      end


      def http_debug
        logger if logger_options.http_debug
      end
    end
  end
end
