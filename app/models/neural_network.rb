# NeuralNetwork class
class NeuralNetwork
   attr_reader :neural_net
  # include Mongoid::Document

 # Net error - this is used to calculate how accurate the result has to be
  NET_ERROR = 0.0001 # 0.00001

  # Initialize NeuralNetwork with arguments
  # :game => LottoGame or MultiGame
  # :data_set => data set after normalization
  # :net_type => ai4r or ruby-fann
  # :net_error => for example 0.01
  # :norm => normaliziation value
  # :data_set and :norm are taken from DataNormalization object
  def initialize(args = {})
    # super
    @data_input = @data_output = args[:data_set]
    @game = args[:game]
    @net_type = args[:net_type]
    @norm = args[:norm]
    @net_error = args[:net_error] || NET_ERROR
    @nuerons_number = @data_input.last.length
    prepare_network
  end

  # Training method
  def train(args = {})
     (@neural_net.is_a? Ai4r::NeuralNetwork::Backpropagation) ? train_ai4r : train_fann(args)
  end

  # Output method is used to test neural network. It takes data table as argument
  def output(data_set)
  end

  # Output method is used to test neural network. It takes data table as argument.
  # Returns results in rounded form
  def output_round(data_set)
  end

  def learning_rate(learning_rate)
     @neural_net.learning_rate = learning_rate
  end

  def train_hash
     start_time = Time.now
    error = 1
    while error > NET_ERROR
        (0...@data_set.length - 1).each do |num|
          error = @neural_net.train(@data_set[num], @data_set[num + 1])
        end
       puts error
     end
     puts "Time for training: #{Time.now - start_time} seconds"
  end

  # Test neural network
  def output_round(input_data)
    # Round to the neares number
     eval_raw(input_data).collect { |x| (x * @norm).round }
  end

  def output(input_data)
     eval_raw(input_data).collect { |x| (x * @norm) }
  end

  private

   # Prepare neural network, select network type
  def prepare_network
     ai4r_net if @net_type.casecmp?('Ai4r')
    fann_net if @net_type.casecmp?('Ruby-Fann')
  end

   # Train ai4r network
  def train_ai4r
  end

   # Train ruby-fann neural network
 def train_fann(args)
    epocs = args[:epocs] || 1000
    err_time = args[:err_time] || 10
    @fann.train_on_data(@train, epocs, err_time, @net_error)
  end

   # Prepare data from game cycles
  def prepare_data_cycles
  # Add 0's at the beggining of the data set
    @data_input.unshift(Array.new(@nuerons_number, 0))
  # Delete last input
    @data_input.delete_at(@data_input.count - 1)
  end

   # Create neural network using Ai4r gem
 # Building neural net with backpropagation algorithm
  # Neural net initialization array example
  # [
  # 	6, - number of input neurons
  # 	3, - hidden layer neurons
  # 	6  - number of output
   # ]
  def ai4r_net
    @neural_net = Ai4r::NeuralNetwork::Backpropagation.new([@nuerons_number, (2 * @nuerons_number) / 3, @nuerons_number])
    @neural_net.learning_rate = 0.5
  end

  # Create neural network using Ruby-Fann gem
  def fann_net
    @neural_net = RubyFann::Standard.new(:num_inputs => @nuerons_number, :hidden_neurons => [(2 * @nuerons_number) / 3], :num_outputs => @nuerons_number)
    @train = RubyFann::TrainData.new(:inputs => @data_input, :desired_outputs => @data_output)
  end

   # Output methods
  def output_fann(data_set)
    @fann.run(data_set).collect { |x| (x * @norm) }
  end

  def output_fann_round(data_set)
    @fann.run(data_set).collect { |x| (x * @norm).round }
  end

  def output_ai4r(data_set)
    @fann.run(data_set).collect { |x| (x * @norm) }
  end

  def output_ai4r_round(data_set)
    @fann.run(data_set).collect { |x| (x * @norm).round }
  end 

  def eval_raw(input_data)
    @neural_net.eval(input_data)
  end
end
