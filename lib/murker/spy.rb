require 'murker/interaction'
require 'murker/generator'
require 'murker/open_api_generator'
require 'murker/repo'
require 'murker/validator'

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
      generator_class = OpenApiGenerator

      @block.call.tap do |result|
        puts "Got #{interactions.count} interactions"
        interactions.each do |interaction|
          schema = generator_class.call(interaction: interaction)
          puts "#{schema}\n\n"
          repo = Repo.new
          if repo.has_schema_for?(interaction)
            schema = repo.retreive_schema_for(interaction)
            res = Validator.call(interaction: interaction, schema: schema, generator_class: generator_class)
            unless res
              raise RuntimeError, 'VALIDATION FAILED'
            end
          else
            repo.store_schema_for(interaction, generator_class: generator_class)
          end
        end
      end
    end

    def add_interaction_by_action_dispatch(request, response)
      @interactions << Interaction.from_action_dispatch(request, response)
    end
  end
end
