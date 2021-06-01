# frozen_string_literal: true

require 'logger'


module ClicksignRb
  class ApplicationLogger < Logger
    FORMATTER = proc do |severity, datetime, progname, msg|
      "#{severity} - #{datetime} - #{progname}: #{msg}\n"
    end


    def initialize(options)
      super(
        options.out || STDOUT,
        level:     options.level || DEBUG,
        formatter: options.formatter || FORMATTER,
        progname:  options.progname || 'ClicksignRb'
      )
    end
  end
end

