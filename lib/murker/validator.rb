require 'murker/generator'

module Murker
  # Validates an interaction against a schema
  class Validator
    def self.call(interaction:, schema:, generator_class: Generator)
      interaction_schema = generator_class.call(interaction: interaction)

      interaction_schema == schema
    end
  end
end
