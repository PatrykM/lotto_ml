# CycleController responsible for actions on Cycles
class CycleController < ApplicationController
  def index; end

  def show
    @cycles = Cycle.where(game_type: params[:game])
  end
end
