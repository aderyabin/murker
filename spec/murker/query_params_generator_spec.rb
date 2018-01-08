require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Murker::QueryParamsGenerator do
  # rubocop:enable Metrics/BlockLength
  describe '#call' do
    let(:schema) { described_class.call(params) }

    context 'param is an Array from ?id[]=1&id[]=2&id[]=3' do
      let(:params) { { 'ids' => %w[1 2 3] } }
      expected_schema = [{
        'in' => 'query',
        'name' => 'ids',
        'description' => 'ids',
        'schema' => {
          'type' => 'array',
          'minItems' => 1,
          'uniqueItems' => true,
          'items' => { 'type' => 'string' },
        },
        'required' => true,
      }]
      it { expect(schema).to eq expected_schema }
    end

    context 'param is a Hash from ?martian[name]=spajic&martian[age]=30' do
      let(:params) { { 'martian' => { 'name' => 'spajic', 'age' => '30' } } }
      expected_schema = [{
        'in' => 'query',
        'name' => 'martian',
        'description' => 'martian',
        'schema' => {
          'type' => 'object',
          'required' => %w[name age],
          'properties' => { 'name' => { 'type' => 'string' }, 'age' => { 'type' => 'string' } },
        },
        'required' => true,
      }]
      it { expect(schema).to eq expected_schema }
    end

    context 'param is a String from ?id=1' do
      let(:params) { { 'id' => '1' } }
      expected_schema = [{
        'in' => 'query',
        'name' => 'id',
        'description' => 'id',
        'schema' => { 'type' => 'string' },
        'required' => true,
      }]
      it { expect(schema).to eq expected_schema }
    end
  end
end
