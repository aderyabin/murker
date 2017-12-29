require 'murker/version'
require 'murker/spy'

module Murker
  def self.capture(&block)
    Spy.on(&block)
  end
end
