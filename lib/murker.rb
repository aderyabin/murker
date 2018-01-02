require 'murker/version'
require 'murker/spy'
require 'murker/interaction'
require 'murker/open_api_generator'

module Murker
  def self.capture(&block)
    Spy.on(&block)
  end
end
