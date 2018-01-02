require 'spec_helper'

RSpec.describe Murker::OpenApiGenerator do
  describe '#call' do
    let(:generator) { described_class.new(interaction) }
    let(:interaction) { Murker::Interaction.new(params) }

    context 'when interaction is GET /martians.json' do
      let(:params) {
        {
          verb: 'GET',
          endpoint_path: '/martians',
          status: 200,
          body: [{"name"=>"spajic", "age"=>30, "ololo"=>"OLOLO"}]
        }
      }
      expected = <<~HEREDOC
        ---
        openapi: 3.0.0
        paths:
          "/martians":
            get:
              responses:
                "'200'":
                  content:
                    application/json:
                      schema:
                        type: array
                        minItems: 1
                        uniqueItems: true
                        items:
                          type: object
                          required:
                          - name
                          - age
                          - ololo
                          properties:
                            name:
                              type: string
                            age:
                              type: integer
                            ololo:
                              type: string
      HEREDOC

      it { expect(generator.call).to eq expected }
    end

    context 'when interaction is GET /martians/1.json' do
      let(:params) {
        {
          verb: 'GET',
          endpoint_path: '/martians/:id',
          status: 200,
          body: {"name"=>"spajic", "age"=>30, "ololo"=>"OLOLO"}
        }
      }
      expected = <<~HEREDOC
        ---
        openapi: 3.0.0
        paths:
          "/martians/{id}":
            get:
              responses:
                "'200'":
                  content:
                    application/json:
                      schema:
                        type: object
                        required:
                        - name
                        - age
                        - ololo
                        properties:
                          name:
                            type: string
                          age:
                            type: integer
                          ololo:
                            type: string
      HEREDOC

      it { expect(generator.call).to eq expected }
    end
  end
end
