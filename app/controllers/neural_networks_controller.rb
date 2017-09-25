# NeuralNetworksController class
class NeuralNetworksController < ApplicationController
  def index
    @networks = NeuralNetwork.all.order_by(created_at: 'asc')
  end

  def new
    @games = if !params[:game_type].nil?
               params[:game_type].constantize.all.page params[:page]
             else
               MultiGame.all.page params[:page]
             end
  end

  # Create new network
  def create
    @neural_network = selected_network_type.new(network_args)
    @neural_network.train

    if @neural_network.save
      connect_games_and_network
      redirect_to neural_network_path(@neural_network), flash: { success: 'Sieć została dodana' }
    else
      redirect_to root_path, flash: { danger: 'Bład sieć nie została dodana' }
    end
  end

  # Find and load network data
  def show
    @neural_network = NeuralNetwork.find(params[:id])
    @neural_network.load_network unless @neural_network.neural_net
    test_network if params[:test_data]
  end

  private

  # Hash for neural network initializer
  def network_args
    data_normalization = DataNormalization.new(game_results.map(&:result))
    { data_input: data_normalization.by_maximum, norm: data_normalization.norm }
  end

  # Connect games and network
  def connect_games_and_network
    game_results.each do |game|
      game.neural_network_ids << @neural_network.id
      game.save
      @neural_network.game_ids << game.id
    end
    @neural_network.save
  end

  # Test network results against different input data
  def test_network
    @test_result = @neural_network.output_round(params[:test_data].split(',').map(&:to_i))
  end

  # Extract results list from params and return array with id's
  def game_results
    results_list = params['neural_network_data']['results_list']
    return unless results_list
    Game.find(results_list.split(','))
  end

  # Return results from game selected by user
  def selected_game
    game_type = params['neural_network_data']['game_type']
    return LottoGame if game_type == 'lotto_game'
    return MultiGame if game_type == 'multi_game'
  end

  # Return network type selected by user
  def selected_network_type
    network_type = params['neural_network_data']['network_type']
    return NeuralNetworkAi4r if network_type == 'ai4r'
    return NeuralNetworkFann if network_type == 'ruby-fann'
  end
end
