require 'murker/interaction'

module Murker
  class Spy
    attr_reader :interactions

    def initialize(&block)
      @block = block
      @interactions = []
    end

    def self.on(&block)
      require 'lurker/spec_helper' unless defined? Murker::SpecHelper

      spy = new(&block)
      Thread.current[:murker_spy] = spy
      spy.call
    ensure
      Thread.current[:murker_spy] = nil
    end

    def self.current
      Thread.current[:murker_spy]
    end

    def self.enabled?
      current.present?
    end

    def call
      @block.call.tap do |result|
        puts "Got #{interactions.count} interactions"
        interactions.each { |interaction| puts "#{pp interaction}\n\n" }
      end
    end

    def add_interaction_by_action_dispatch(request, response)
      @interactions << Interaction.from_action_dispatch(request, response)
    end
  end
end
