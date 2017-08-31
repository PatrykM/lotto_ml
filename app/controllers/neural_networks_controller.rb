# NeuralNetworksController class
class NeuralNetworksController < ApplicationController
  def index
    # to implement
  end

  def new
    @games = if !params[:game_type].nil?
               params[:game_type].constantize.all.page params[:page]
             else
               MultiGame.all.page params[:page]
             end
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
    return LottoGame if game_type == 'lotto_game'
    return MultiGame if game_type == 'multi_game'
  end
end
