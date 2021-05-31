# frozen_string_literal: true


module ClicksignRb
  module Config
      REQUIRED_ATTRIBUTES = [:host, :token]
      OPTIONAL_ATTRIBUTES = { api_version: 'v1' }


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
    end
  end
end
