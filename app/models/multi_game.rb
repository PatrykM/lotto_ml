# MultiMulti Game class
class MultiGame < Game
	# Data number used for import
	# First field - date and time
	# Rest 20 is for results
	def game_format
		21
	end
	
	def game_range
		1..80
	end
end
