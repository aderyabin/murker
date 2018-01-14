require 'json-schema-generator'

module Murker
  # Utilities methods
  module Utils
    JSON_SCHEMA_UNWANTED_FIELDS = %w[$schema description].freeze

    module_function

    def schema_by_object(obj)
      serialized_schema = JSON::SchemaGenerator.generate(
        '', # comment for generated json, we don't need it
        JSON.dump(obj),
        schema_version: 'draft4',
      )
      schema_object = JSON.parse(serialized_schema)
      remove_unexpected_fields(schema_object)
    end

    def remove_unexpected_fields(schema_object)
      schema_object.tap do |schema|
        JSON_SCHEMA_UNWANTED_FIELDS.each { |field| schema.delete field }
      end
    end
  end
end
