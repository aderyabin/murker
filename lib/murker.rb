require 'murker/version'
require 'murker/spy'
require 'murker/interaction'

module Murker
  def self.capture(&block)
    Spy.on(&block)
  end
end
