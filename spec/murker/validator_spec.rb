require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Murker::Validator do
  describe '#call' do
    # rubocop:enable Metrics/BlockLength
    let(:validator) { described_class }
    let(:stored_schema) { expected_get_martians_schema }

    context 'when schemas are equal' do
      it {
        expect(validator.call(new_schema: stored_schema, stored_schema: stored_schema))
          .to be nil
      }
    end

    context 'when new_schema fails validation against stored_schema' do
      let(:modified_schema) do
        expected_get_martians_schema.tap do |schema|
          schema['openapi'] = '4.0.0'
          response_schema = schema.dig(
            'paths', '/martians', 'get', 'responses', "'200'", 'content', 'application/json'
          )
          response_schema['schema']['items']['properties'] = { 'name' => { 'type' => 'string' } }
        end
      end

      expected_error_description = [
        { 'op' => 'replace', 'path' => '/openapi', 'was' => '3.0.0', 'value' => '4.0.0' },
        {
          'op' => 'remove',
          'path' => "/paths/~1martians/get/responses/'200'/content"\
            '/application~1json/schema/items/properties/age',
          'was' => { 'type' => 'integer' },
        },
      ]

      it {
        expect(
          validator.call(new_schema: modified_schema, stored_schema: stored_schema),
        ).to eq expected_error_description
      }
    end

    context 'when new_schema reorders objects fields and should be valid' do
      it {
        expect(
          validator.call(
            new_schema: expected_get_martians_schema_reordered,
            stored_schema: stored_schema,
          ),
        ).to be nil
      }
    end
  end
end
