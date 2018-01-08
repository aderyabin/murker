# Helpers for specs
# rubocop:disable Metrics/ModuleLength
module Helpers
  # rubocop:enable Metrics/ModuleLength
  def schema(endpoint:, verb:, response:, parameters: nil)
    schema = {
      'openapi' => '3.0.0',
      'info' => { 'title' => 'Generated by Murker', 'version' => '0.1.0' },
    }
    response_and_params =
      if parameters
        { 'parameters' => parameters, 'responses' => response }
      else
        { 'responses' => response }
      end

    schema['paths'] = { endpoint => { verb => response_and_params } }

    schema
  end

  def response_schema(code:, description:, content_schema:)
    {
      "'#{code}'" => {
        'description' => description,
        'content' => { 'application/json' => { 'schema' => content_schema } },
      },
    }
  end

  def expected_get_martians_schema
    schema(
      endpoint: '/martians',
      verb: 'get',
      response: response_schema(
        code: 200,
        description: 'GET /martians -> 200',
        content_schema: {
          'type' => 'array',
          'minItems' => 1,
          'uniqueItems' => true,
          'items' => {
            'type' => 'object',
            'required' => %w[name age],
            'properties' => {
              'name' => { 'type' => 'string' }, 'age' => { 'type' => 'integer' }
            },
          },
        },
      ),
    )
  end

  def expected_get_martians_schema_reordered
    schema(
      endpoint: '/martians',
      verb: 'get',
      response: response_schema(
        code: 200,
        description: 'GET /martians -> 200',
        content_schema: {
          'type' => 'array',
          'minItems' => 1,
          'uniqueItems' => true,
          'items' => {
            'type' => 'object',
            'required' => %w[name age],
            'properties' => { # was name, age
              'age' => { 'type' => 'integer' }, 'name' => { 'type' => 'string' }
            },
          },
        },
      ),
    )
  end

  def expected_get_martian_schema
    schema(
      endpoint: '/martians/{id}',
      verb: 'get',
      parameters: [{
        'in' => 'path', 'name' => 'id', 'description' => 'id',
        'schema' => { 'type' => 'integer' },
        'required' => true, 'example' => '1'
      }],
      response: response_schema(
        code: 200,
        description: 'GET /martians/:id -> 200',
        content_schema: {
          'type' => 'object', 'required' => %w[name age],
          'properties' => {
            'name' => { 'type' => 'string' }, 'age' => { 'type' => 'integer' }
          }
        },
      ),
    )
  end

  def expected_get_pet_with_query_params_schema
    schema(
      endpoint: '/martians/{martian_id}/pets/{id}',
      verb: 'get',
      parameters: [{
        'in' => 'path', 'name' => 'martian_id', 'description' => 'martian_id',
        'schema' => { 'type' => 'integer' }, 'required' => true, 'example' => '1'
      }, {
        'in' => 'query', 'name' => 'name', 'description' => 'name',
        'schema' => { 'type' => 'string' }, 'required' => true
      }, {
        'in' => 'query', 'name' => 'age', 'description' => 'age',
        'schema' => { 'type' => 'string' }, 'required' => true
      }],
      response: response_schema(
        code: 200,
        description: 'GET /martians/:martian_id/pets/:id -> 200',
        content_schema: {
          'type' => 'object', 'required' => %w[name weight],
          'properties' => {
            'name' => { 'type' => 'string' }, 'weight' => { 'type' => 'integer' }
          }
        },
      ),
    )
  end
end
