module Murker
  # Validates new_schema vs stored_schema and returns validation error
  # Schemas are ruby objects representing OpenApi3 schema
  class Validator
    def self.call(new_schema:, stored_schema:)
      return if new_schema == stored_schema

      'VALIDATION FAILED'
    end
  end
end
