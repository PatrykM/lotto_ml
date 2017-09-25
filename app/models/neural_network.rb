# NeuralNetwork class
class NeuralNetwork
  attr_reader :neural_net
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :dump, type: String
  has_and_belongs_to_many :games

  # Net error - this is used to calculate how accurate the result has to be
  NET_ERROR = 0.001 # 0.00001

  # Initialize NeuralNetwork with arguments
  # :game => LottoGame or MultiGame
  # :data_set => data set after normalization
  # :net_error => for example 0.01
  # :norm => normalization value
  # :data_set and :norm are taken from DataNormalization object
  def initialize(args = {})
    @data_input = args[:data_input]
    @nuerons_number = @data_input.last.length
    @game = args[:game]
    @norm = args[:norm]
    @net_error = args[:net_error] || NET_ERROR
    @neural_net = args[:neural_net]
    # if @neural_net
    #   load_network
    # else
    #   prepare_network
    # end
    prepare_network
    super
  end

  # Generic output method is used to prepare data
  # Main method must be implemented in child class
  def output(input_data)
    input_data.collect! { |num| num / norm }
  end

  # Output method is used to test neural network. It takes data table as argument
  def output_round(input_data)
    # Round to the neares number
    output(input_data).map(&:round)
  end

  # Output only type of the network
  def ntype; end

  # Training method to implement
  def train(args = {}); end

  private

  # Preparing network
  def prepare_network; end

  # Save network
  def dump_network; end

  # Load saved network
  def load_network; end
end
