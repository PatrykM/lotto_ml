# NeuralNetwork class used with ruby-fann gem
class NeuralNetworkFann < NeuralNetwork
  # Training method
  def train(args = {})
    # Settings for fann network
    epocs = args[:epocs] || 1000
    err_time = args[:err_time] || 10
    # Training network
    @neural_net.train_on_data(train_set, epocs, err_time, @net_error)
  end

  # Output methods
  def output(input_data)
    @neural_net.run(super).collect { |result| (result * @norm) }
  end

  private

  # Create neural network using Ruby-Fann gem
  def prepare_network
    @neural_net = RubyFann::Standard.new(num_inputs: @nuerons_number,
                                         hidden_neurons: [(2 * @nuerons_number) / 3],
                                         num_outputs: @nuerons_number)
  end

  # Train set based on input data
  def train_set
    data_input = data_output = @data_input
    data_input.delete_at(data_input.index(data_input.last))
    data_output.delete_at(data_output.index(data_output.first))
    RubyFann::TrainData.new(inputs: data_input,
                            desired_outputs: data_output)
  end
end
