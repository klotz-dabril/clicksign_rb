# frozen_string_literal: true
#
require 'thor'

require 'clicksign_rb'
require 'clicksign_rb/cli/subcommand_base'
require 'clicksign_rb/cli/document'


ClicksignRb.configure do |config|
  config.logger_options.level =  4
  config.logger_options.out   = STDERR
end


module ClicksignRb
  module CLI
    class Engine < Thor
      package_name "ClickSign"
      map '-v' => :version


      desc "version", 'Print version and exit.'
      def version
        puts VERSION
      end


      desc "document", 'document'
      subcommand "document", Document


      def self.exit_on_failure?
        true
      end
    end
  end
end
