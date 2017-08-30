# NeuralNetworksController class
class NeuralNetworksController < ApplicationController
  def index
    # to implement
  end

  def new
    # to implement
    @neural_network = ''
    @games = MultiGame.all.page params[:page]
    #if selected_game.all.page params[:page]
  end

  def create
    # to implement
  end

  def train
    # to implement
  end

  private

  # Return results from game selected by user
  def selected_game
    game_type = params['neural_network_data']['game_type']
    return LottoGame if game_type == "lotto_game"
    return MultiGame if game_type == "multi_game"
  end
end
