require 'murker/version'
require 'murker/spy'

module Murker
  def self.capture(&block)
    spy = Spy.new(&block)
    spy.call
  end
end
