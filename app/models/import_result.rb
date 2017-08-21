# ImportResult class used for importing games results
class ImportResult
  require 'csv'
  # Method used to import data. First argument is a file with data,
  # second is a game object
  def initialize(file, game)
  	@file = file
  	@game = game
  end
  # Main import method
  def import  	
	  CSV.foreach(@file) do |draw|
	  	@game.class.create(
        draw_date: draw.first, 
        result: draw[1..@game.game_format].map(&:to_i)
      ) 
		end
  end
end
