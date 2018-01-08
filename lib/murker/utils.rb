require 'json-schema-generator'

module Murker
  # Utilities methods
  module Utils
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
  end
end
