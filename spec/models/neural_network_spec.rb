require 'rails_helper'

RSpec.describe NeuralNetwork, type: :model do
  #let(:neural_network) { NeuralNetwork.new }
  # Data are just for example, there will be no calculation on it
	

  it "has default net error set to 0.0001" do
  	expect(NeuralNetwork::NET_ERROR).to eq 0.0001
  end

	context "ai4r network type" do
  	let(:ai4r_net) { build(:ai4r_neural_network) }

  	it "is a ai4r type network" do

  		expect(ai4r_net.neural_net).to be_a(Ai4r::NeuralNetwork::Backpropagation)
  	end

  	it ".train calls train_ai4r" do
  		allow(ai4r_net).to receive(:train_ai4r)
  		expect(ai4r_net).to receive(:train_ai4r)
  		ai4r_net.train
  	end
  	
  end  

  context "ruby-fann network type" do
  	let(:fann_net) { build(:fann_neural_network) }

  	it "is a fann type network" do
  		expect(fann_net.neural_net).to be_a(RubyFann::Standard)
  	end

  	it ".train calls train_fann" do
  		allow(fann_net).to receive(:train_fann)
  		expect(fann_net).to receive(:train_fann)
  		fann_net.train
  	end

		it ".train calls train_fann wit arguments" do
  		allow(fann_net).to receive(:train_fann).with(hash_including(:epocs => 1000, :err_time => 30))
  		expect(fann_net).to receive(:train_fann).with(hash_including(:epocs => 1000, :err_time => 30))
  		fann_net.train({:epocs => 1000, :err_time => 30})
  	end

  end
end
