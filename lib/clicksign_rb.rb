# frozen_string_literal: true

require 'pry'

require "clicksign_rb/config"
require "clicksign_rb/error"
require "clicksign_rb/version"

require "clicksign_rb/dispatcher"

module ClicksignRb
  class << self
    def configure(&block)
      Config.configure &block
    end
  end
end
