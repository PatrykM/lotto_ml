# NeuralNetwork class used with Ai4r gem
class NeuralNetworkAi4r < NeuralNetwork
  # Training method
  def train
    error = 1
    while error > @net_error
      (0...@data_input.length - 1).each do |num|
        error = @neural_net.train(@data_input[num], @data_input[num + 1])
      end
    end
  end

  # Output method is used to test neural network. It takes data table as argument.
  def output(input_data)
    # Get results from the network and multiply by @norm parameter to get 'real' data
    @neural_net.eval(super).collect { |result| (result * norm) }
  end

  # Save network to file
  def save
    network_dumper = NetworkDumper.new
    ai4r_dump = Marshal.dump(@neural_net).force_encoding('ISO-8859-1').encode('UTF-8')
    File.open(network_dumper.file_name.to_s, 'w') do |file|
      file.write(ai4r_dump)
    end
    self.dump = network_dumper.file_md5
    super
  end

  # Load saved network
  def load_network
    @neural_net = Marshal.load(File.read(dump).encode('ISO-8859-1'))
  end

  # Output only type of the network
  def ntype
    'Ai4r'
  end

  private

  # Create neural network using Ai4r gem
  # Building neural net with backpropagation algorithm
  # Neural net initialization array example
  # [
  # => 6, - number of input neurons
  # => 3, - hidden layer neurons
  # => 6  - number of output
  # ]
  def prepare_network
    @neural_net = Ai4r::NeuralNetwork::Backpropagation.new([@nuerons_number,
                                                            (2 * @nuerons_number) / 3,
                                                            @nuerons_number])
    # Set learning rate for the network
    @neural_net.learning_rate = 0.5
  end
end
