# frozen_string_literal: true

require 'pry'

require "clicksign_rb/config"
require "clicksign_rb/version"

module ClicksignRb
  class Error < StandardError; end

  class << self
    def configure(&block)
      Config.configure &block
    end
  end
end
