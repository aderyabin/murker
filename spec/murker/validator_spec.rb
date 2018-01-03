require 'spec_helper'

RSpec.describe Murker::Validator do
  describe '#call' do
    let(:validator) { described_class }
    let(:stored_schema) do
      {
        'openapi' => '3.0.0',
        'paths' => {
          '/martians' => {
            'get' => {
              'responses' => {
                "'200'" => {
                  'content' => {
                    'application/json' => {
                      'schema' => {
                        'type' => 'array',
                        'minItems' => 1,
                        'uniqueItems' => true,
                        'items' => {
                          'type' => 'object',
                          'required' => ['name', 'age', 'ololo'],
                          'properties' => {
                            'name' => { 'type' => 'string' },
                            'age' => { 'type' => 'integer' },
                            'ololo' => { 'type' => 'string' }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    end

    context 'when schemas are equal' do
      it {
        expect(validator.call(new_schema: stored_schema, stored_schema: stored_schema))
          .to be nil
      }
    end

    context 'when new_schema fails validation against stored_schema' do
      new_schema = {
        'openapi' => '4.0.0',
        'paths' => {
          '/martians' => {
            'get' => {
              'responses' => {
                "'200'" => {
                  'content' => {
                    'application/json' => {
                      'schema' => {
                        'type' => 'array',
                        'minItems' => 1,
                        'uniqueItems' => true,
                        'items' => {
                          'type' => 'object',
                          'required' => ['name', 'age'],
                          'properties' => {
                            'name' => { 'type' => 'string' },
                            'age' => { 'type' => 'string' }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }

      expected_error_description = [
        {'op'=>'replace', 'path'=>'/openapi', 'was'=>'3.0.0', 'value'=>'4.0.0'},
        {'op'=>'remove',
         'path'=>
          "/paths/~1martians/get/responses/'200'/content/application~1json/schema/items/required/2",
         'was'=>'ololo'},
        {'op'=>'remove',
         'path'=>
          "/paths/~1martians/get/responses/'200'/content/application~1json/schema/items/properties/ololo",
         'was'=>{'type'=>'string'}},
        {'op'=>'replace',
         'path'=>
          "/paths/~1martians/get/responses/'200'/content/application~1json/schema/items/properties/age/type",
         'was'=>'integer',
         'value'=>'string'}
       ]

      it {
        expect(validator.call(new_schema: new_schema, stored_schema: stored_schema))
          .to eq expected_error_description
      }
    end

    context 'when new_schema reorders objects fields and should be valid' do
      new_schema = {
        'openapi' => '3.0.0',
        'paths' => {
          '/martians' => {
            'get' => {
              'responses' => {
                "'200'" => {
                  'content' => {
                    'application/json' => {
                      'schema' => {
                        'minItems' => 1,
                        'type' => 'array',
                        'uniqueItems' => true,
                        'items' => {
                          'type' => 'object',
                          'required' => ['name', 'age', 'ololo'],
                          'properties' => {
                            'ololo' => { 'type' => 'string' },
                            'name' => { 'type' => 'string' },
                            'age' => { 'type' => 'integer' }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }

      it {
        expect(validator.call(new_schema: new_schema, stored_schema: stored_schema))
          .to be nil
      }
    end
  end
end
