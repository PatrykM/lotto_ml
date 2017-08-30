# NeuralNetwork class
class NeuralNetwork
  attr_reader :neural_net
  # include Mongoid::Document

  # Net error - this is used to calculate how accurate the result has to be
  NET_ERROR = 0.001 # 0.00001

  # Initialize NeuralNetwork with arguments
  # :game => LottoGame or MultiGame
  # :data_set => data set after normalization
  # :net_error => for example 0.01
  # :norm => normalization value
  # :data_set and :norm are taken from DataNormalization object
  def initialize(args = {})
    # super
    @data_input = args[:data_set]
    @nuerons_number = @data_input.last.length
    @game = args[:game]
    @norm = args[:norm]
    @net_error = args[:net_error] || NET_ERROR
    prepare_network
  end

  # Generic output method is used to prepare data
  # Main method must be implemented in child class
  def output(input_data)
    input_data.collect! { |num| num / @norm }
  end

  # Output method is used to test neural network. It takes data table as argument
  def output_round(input_data)
    # Round to the neares number
    output(input_data).map(&:round)
  end

  # Training method to implement
  def train(args = {}); end

  private

  # Preparing network
  def prepare_network; end

  # for future
  # def train_hash
  #   error = 1
  #   while error > NET_ERROR
  #     (0...@data_set.length - 1).each do |num|
  #       error = @neural_net.train(@data_set[num], @data_set[num + 1])
  #     end
  #   end
  # end

  # # Prepare data from game cycles
  # def prepare_data_cycles
  #   # Add 0's at the beggining of the data set
  #   @data_input.unshift(Array.new(@nuerons_number, 0))
  #   # Delete last input
  #   @data_input.delete_at(@data_input.count - 1)
  # end
end
