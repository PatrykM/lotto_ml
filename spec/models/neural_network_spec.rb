require 'rails_helper'

RSpec.describe NeuralNetwork, type: :model do
  # Data are just for example, there will be no calculation on it
  let(:data_input) { [[1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6]] }
  let(:norm) { 6 }

  it 'has default net error set to 0.0001' do
    expect(NeuralNetwork::NET_ERROR).to eq 0.001
  end

  context 'ai4r network type' do
    let(:ai4r_net) { NeuralNetworkAi4r.new(data_input: data_input, norm: norm) }

    it 'is a ai4r type network' do
      expect(ai4r_net.neural_net).to be_a(Ai4r::NeuralNetwork::Backpropagation)
    end
  end

  context 'ruby-fann network type' do
    let(:fann_net) { NeuralNetworkFann.new(data_input: data_input, norm: norm) }

    it 'is a fann type network' do
      expect(fann_net.neural_net).to be_a(RubyFann::Standard)
    end

    it '.train calls train_fann wit arguments' do
      allow(fann_net).to receive(:train).with(hash_including(epocs: 1000, err_time: 30))
      expect(fann_net).to receive(:train).with(hash_including(epocs: 1000, err_time: 30))
      fann_net.train(epocs: 1000, err_time: 30)
    end
  end
end
