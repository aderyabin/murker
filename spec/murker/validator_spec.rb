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
      new_schema = expected_get_martians_schema
      new_schema['openapi'] = '4.0.0'
      schema = new_schema.dig(
        'paths', '/martians', 'get', 'responses', "'200'", 'content', 'application/json', 'schema'
      )
      schema['items']['properties'] = { 'name' => { 'type' => 'string' } }

      expected_error_description = [
        { 'op' => 'replace', 'path' => '/openapi', 'was' => '3.0.0', 'value' => '4.0.0' },
      ]

      it {
        expect(validator.call(new_schema: new_schema, stored_schema: stored_schema))
          .to eq expected_error_description
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
