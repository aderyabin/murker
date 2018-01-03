require 'murker/version'
require 'murker/spy'
require 'murker/interaction'
require 'murker/generator'
require 'murker/validator'
require 'murker/repo'

module Murker
  def self.capture(&block)
    Spy.on(&block)
  end

  def self.handle_captured_interactions(interactions)
    interactions.each do |interaction|
      schema = Generator.call(interaction: interaction)
      repo = Repo.new
      if repo.has_schema_for?(interaction)
        schema = repo.retreive_schema_for(interaction)
        res = Validator.call(interaction: interaction, schema: schema)
        unless res
          raise RuntimeError, 'VALIDATION FAILED'
        end
      else
        repo.store_schema_for(interaction)
      end
    end
  end
end
