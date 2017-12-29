module Murker
  class Spy
    def initialize(&block)
      @block = block
    end

    def call
      @block.call.tap do |result|
      end
    end
  end
end
