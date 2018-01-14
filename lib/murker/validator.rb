require 'murker/error_formatter'

module Murker
  # Validates new_schema vs stored_schema and returns validation error
  # Schemas are ruby objects representing OpenApi3 schema
  class Validator
    UNNECESSARY_FIELDS = %w[description example].freeze

    def self.call(new_schema:, stored_schema:)
      prepared_new_schema = remove_unnecessary_fields(new_schema)
      prepared_stored_schema = remove_unnecessary_fields(stored_schema)

      return if prepared_new_schema == prepared_stored_schema

      ErrorFormatter.call(prepared_new_schema, prepared_stored_schema)
    end

    def self.remove_unnecessary_fields(schema)
      return unless schema.is_a?(Hash)

      schema.each do |key, value|
        if UNNECESSARY_FIELDS.include? key
          schema.delete key
        elsif value.is_a?(Array)
          value.each { |v| remove_unnecessary_fields(v) }
        elsif value.is_a?(Hash)
          remove_unnecessary_fields(value)
        end
      end

      schema
    end
  end
end
