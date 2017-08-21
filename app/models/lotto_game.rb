# Lotto game class
class LottoGame < Game
  # Data number used for import
  # First field - date and time
  # Rest 6 is for results
  def game_format
    7
  end

  def game_range
    1..49
  end
end
