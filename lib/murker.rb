require 'murker/version'
require 'murker/spy'
require 'murker/interaction'
require 'murker/generator'
require 'murker/validator'
require 'murker/repo'

module Murker
  class MurkerError < StandardError; end
  class ValidationError < MurkerError; end

  def self.capture(&block)
    Spy.on(&block)
  end

  def self.handle_captured_interactions(interactions)
    validation_errors =
      interactions.each_with_object([]) do |interaction, errors|
        if Repo.has_schema_for?(interaction)
          stored_schema = Repo.retreive_schema_for(interaction)
          new_schema = Generator.call(interaction: interaction)
          errors << Validator.call(new_schema: new_schema, stored_schema: stored_schema)
        else
          Repo.store_schema_for(interaction)
        end
      end.compact
    return if validation_errors.empty?

    error_message = validation_errors.join("\n")
    raise ValidationError, error_message
  end
end
