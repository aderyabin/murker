require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Murker::Generator do
  # rubocop:enable Metrics/BlockLength
  describe '#call' do
    let(:generator) { described_class.new(interaction: interaction) }
    let(:interaction) { Murker::Interaction.new(params) }

    context 'when interaction is GET /martians.json' do
      let(:params) do
        {
          verb: 'GET',
          endpoint_path: '/martians',
          status: 200,
          body: [{ 'name' => 'spajic', 'age' => 30 }],
        }
      end
      it { expect(generator.call).to eq expected_get_martians_schema }
    end

    context 'when interaction is GET /martians/1.json' do
      let(:params) do
        {
          verb: 'GET',
          endpoint_path: '/martians/:id',
          path_params: { 'controller' => 'v1/martians', 'action' => 'show', 'id' => '1' },
          status: 200,
          body: { 'name' => 'spajic', 'age' => 30 },
        }
      end
      it { expect(generator.call).to eq expected_get_martian_schema }
    end
  end
end
