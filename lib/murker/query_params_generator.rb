require 'murker/utils'
require 'pry'
module Murker
  # Generates OpenAPI v3 schema for query_params of Interaction
  class QueryParamsGenerator
    include Murker::Utils

    attr_reader :params

    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
    end

    def call
      return if params.nil? || params.empty?

      params.map { |name, value| schema_for_path_param(name, value) }
    end

    private

    def schema_for_path_param(name, value)
      {
        'in' => 'query',
        'name' => name.to_s,
        'description' => name.to_s,
        'schema' => schema_by_query_param_value(value),
        'required' => true,
      }
    end

    # Value may be Array, Hash, or String
    def schema_by_query_param_value(value)
      case value
      when Array
        schema_by_object(value)
      when Hash
        schema_by_object(value)
      else
        { 'type' => 'string' }
      end
    end
  end
end
