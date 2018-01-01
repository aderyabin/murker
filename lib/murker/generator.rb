module Murker
  # In: Interaction
  # Out: Schema
  class Generator
    attr_reader :interaction

    def initialize(interaction:)
      @interaction = interaction
    end

    def self.call(interaction:)
      new(interaction: interaction).call
    end

    def call
      interaction_properties.join(', ')
    end

    private

    def interaction_properties
      [
        interaction.verb,
        interaction.endpoint_path,
        interaction.path_info,
        interaction.path_params,
        interaction.query_params,
        interaction.payload,
        interaction.status,
        interaction.body
      ]
    end
  end
end
