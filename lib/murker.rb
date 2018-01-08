require 'murker/version'
require 'murker/spy'
require 'murker/interaction'
require 'murker/generator'
require 'murker/validator'
require 'murker/repo'

# Main module
module Murker
  class MurkerError < StandardError; end
  class ValidationError < MurkerError; end

  def self.capture(&block)
    Spy.on(&block)
  end

  def self.handle_captured_interactions(interactions)
    validation_errors =
      interactions.each_with_object([]) do |interaction, errors|
        if Repo.schema_for?(interaction)
          stored_schema = Repo.retreive_schema_for(interaction)
          new_schema = Generator.call(interaction: interaction)
          validation_error =
            Validator.call(new_schema: new_schema, stored_schema: stored_schema)
          errors << [interaction, validation_error] if validation_error
        else
          Repo.store_schema_for(interaction)
        end
      end
    return if validation_errors.empty?

    raise ValidationError, build_error_message(validation_errors)
  end

  def self.build_error_message(validation_errors)
    error_message = "MURKER VALIDATION FAILED!\n\n"
    validation_errors.each do |interaction, error|
      interaction_name = "#{interaction.verb} #{interaction.endpoint_path}"
      error_message <<
        "Interaction '#{interaction_name}' failed with the following reason:\n" \
        "#{error}\n\n"
    end
    error_message
  end
end
