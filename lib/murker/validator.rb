require 'murker/generator'

module Murker
  # Validates an interaction against a schema
  class Validator
    def self.call(interaction:, schema:)
      interaction_schema = Generator.call(interaction: interaction)

      YAML.load(interaction_schema) == YAML.load(schema)
    end
  end
end
