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
      if Repo.has_schema_for?(interaction)
        stored_schema = Repo.retreive_schema_for(interaction)
        new_schema = Generator.call(interaction: interaction)
        res = Validator.call(new_schema: new_schema, stored_schema: stored_schema)
        unless res
          raise RuntimeError, 'VALIDATION FAILED'
        end
      else
        Repo.store_schema_for(interaction)
      end
    end
  end
end
