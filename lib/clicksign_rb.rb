# frozen_string_literal: true

require "clicksign_rb/config"
require "clicksign_rb/error"
require "clicksign_rb/version"

require "clicksign_rb/dispatcher"

require 'clicksign_rb/document.rb'


module ClicksignRb
  class << self
    def configure(&block)
      Config.configure &block
    end
  end
end
