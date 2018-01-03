require 'json-schema-generator'

module Murker
  # Generates OpenAPI v3 schema for Interaction
  # Output is Ruby object representing schema, it may be serialized to yml|json
  class Generator
    OPEN_API_VERSION = '3.0.0'.freeze
    OPEN_API_INFO = {
      'title' => 'Generated by Murker',
      'version' => Murker::VERSION.to_s
    }.freeze
    JSON_SCHEMA_VERSION = 'draft4'.freeze
    JSON_SCHEMA_UNWANTED_FIELDS = %w[$schema description].freeze
    APPLICATION_JSON_CONTENT_TYPE = 'application/json'.freeze

    attr_reader :interaction

    extend Forwardable
    delegate [:verb, :endpoint_path, :path_info, :path_params, :body, :status] => :interaction

    def initialize(interaction:)
      @interaction = interaction
    end

    def self.call(interaction)
      new(interaction).call
    end

    def call
      {
        'openapi' => OPEN_API_VERSION,
        'info' => OPEN_API_INFO,
        'paths' => {
          change_path_params_from_colon_to_curly_braces(endpoint_path) => {
            verb.downcase => verb_schema
          }
        }
      }
    end

    private

    def verb_schema
      params_schema = parameters_schema
      if params_schema
        {
          'parameters' => params_schema,
          'responses' => response_schema
        }
      else
        { 'responses' => response_schema }
      end
    end

    def change_path_params_from_colon_to_curly_braces(path)
      path.gsub(/:(\w*)/) { |_s| "{#{$1}}" }
    end

    def parameters_schema
      return if path_params.nil? || path_params.empty?
      params = path_params.reject { |k, _v| %w[controller action].include? k }
      return if params.empty?

      params.map do |name, value|
        {
          'in' => 'path',
          'name' => name,
          'description' => name,
          'schema' => schema_by_path_param_value(value),
          'required' => true,
          'example' => value
        }
      end
    end

    def response_schema
      {
        "'#{status}'" => {
          'description' => "#{verb} #{endpoint_path} -> #{status}",
          'content' => {
            APPLICATION_JSON_CONTENT_TYPE => {
              'schema' => schema_by_object(body)
            }
          }
        }
      }
    end

    def schema_by_path_param_value(value)
      if is_a_positive_ingeger?(value)
        { 'type' => 'integer' }
      else
        { 'type' => 'string' }
      end
    end

    def schema_by_object(obj)
      serialized_schema = JSON::SchemaGenerator.generate('', JSON.dump(obj), schema_version: 'draft4')
      schema_object = JSON.parse(serialized_schema)
      remove_unexpected_fields(schema_object)
    end

    def remove_unexpected_fields(schema_object)
      schema_object.tap do |schema|
        JSON_SCHEMA_UNWANTED_FIELDS.each { |field| schema.delete field }
      end
    end

    def is_a_positive_ingeger?(str)
      /\A\d+\z/.match(str)
    end
  end
end
