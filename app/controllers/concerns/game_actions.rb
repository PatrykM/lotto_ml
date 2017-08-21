# GameActions shared between games
module GameActions
  extend ActiveSupport::Concern

  def index
    @games = controller_class.all.page params[:page]
  end

  def show
    @game
  end

  def new
    @game = controller_class.new
  end

  def create
    game_params

    if @game.save
      redirect_to public_send("#{game_type}_path"), flash: { success: 'Losowanie zostało dodane' }
    else
      redirect_to public_send("new_#{game_type.singularize}_path(#{@game})"), flash: { danger: 'Losowanie nie zostało dodane' }
    end
  end

  private

  # Get controller class
  def controller_class
    controller_name.classify.constantize
  end

  # Read game params
  def game_params
    game_data_params = params['game_data']
    @game = controller_class.new
    @game.result = game_data_params['result'].try(:map, &:to_i)
    @game.draw_date = game_data_params['draw_date']
  end

  def game_type
    @game._type.tableize
  end
end
