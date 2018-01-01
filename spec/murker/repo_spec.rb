require 'spec_helper'

RSpec.describe Murker::Repo do
  describe '#path_for' do
    let(:repo) { described_class.new }
    let(:interaction) { Murker::Interaction.new(params) }

    context 'when interaction is GET v1/martians/:id' do
      let(:params) { { verb: 'GET', endpoint_path: 'v1/martians/:id' } }
      expected = 'spec/murker/v1/martians/__id/GET.txt'

      it { expect(repo.path_for(interaction)).to eq expected }
    end

    context 'when interaction is GET v1/martians.json' do
      let(:params) { { verb: 'GET', endpoint_path: 'v1/martians' } }
      expected = 'spec/murker/v1/martians/GET.txt'

      it { expect(repo.path_for(interaction)).to eq expected }
    end
  end
end
