require 'json-schema-generator'

module Murker
  # Generates OpenAPI v3 schema for Interaction
  class OpenApiGenerator
    OPEN_API_VERSION = '3.0.0'.freeze
    JSON_SCHEMA_VERSION = 'draft4'.freeze
    JSON_SCHEMA_UNWANTED_FIELDS = %w[$schema description].freeze
    APPLICATION_JSON_CONTENT_TYPE = 'application/json'.freeze

    attr_reader :interaction

    def initialize(interaction)
      @interaction = interaction
    end

    def self.call(interaction)
      new(interaction).call
    end

    def call
      schema = {
        'openapi' => OPEN_API_VERSION,
        'paths' => {
          interaction.endpoint_path => {
            interaction.verb.downcase => response_schema
          }
        }
      }
      YAML.dump(schema)
    end

    private

    def response_schema
      {
        'responses' => {
          "'#{interaction.status}'" => {
            'content' => {
              APPLICATION_JSON_CONTENT_TYPE => { 'schema' => body_schema }
            }
          }
        }
      }
    end

    def body_schema
      serialized_schema = JSON::SchemaGenerator.generate(
        '', # description
        JSON.dump(interaction.body),
        schema_version: 'draft4'
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
