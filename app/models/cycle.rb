# Class Cycle is responsible for finding cycles in game results
class Cycle
  include Mongoid::Document
  # Field stages holds all next stages of the cycle.
  # Each entry is an array itself.
  # Each entry array length is the max number of the game range
  # For example LottoGame cycle stages looks like this:
  # Each entry array has 49 fields - max number in LottoGame
  # First entry array is initialized with 0's
  # Next stages adds to previous one.
  # Cycle is finished where there is no 0's in last array
  field :stages, type: Array
  field :game_type, type: String
  has_many :games

  def initialize
    super
    self.stages = []
  end

  # Find cycles in given games
  def find_new(without_cycle)
    stage = new_or_last_stage(without_cycle)

    without_cycle.each do |game|
      calculate_stage(game, stage)
      game.save
      # Check if cycle is done, if not copy last stage
      stages.last.include?(0) ? stage = Array.new(stage) : break
    end
    save
  end

  def stages_summary_table
    # It defines number of input in NN
    last_stage_max = stages.last.max
    stages.map do |stage|
      (0..last_stage_max).map { |num| stage.count(num) }
    end
  end

  # Return unfinished cycle for a given game_type, for example LottoGame
  def self.unfinished(game_type)
    where(game_type: game_type.to_s).detect do |cycle|
      cycle.stages.last.include?(0)
    end
  end

  # Find all cycles for a given game_type, for example LottoGame
  def self.find_in_games(game_type)
    games_without_cycle = game_type.without_cycle
    games_without_cycle_new = []

    while games_without_cycle != games_without_cycle_new
      cycle = unfinished(game_type) || Cycle.new
      # Change it to initialize
      cycle.game_type = game_type
      games_without_cycle_new = games_without_cycle
      cycle.find_new(games_without_cycle) unless games_without_cycle.empty?
      games_without_cycle = game_type.without_cycle
    end
  end

  private

  # First stage array with initialized with 0's or
  # with last stage of existing cycle
  def new_or_last_stage(without_cycle)
    stage = if new_record?
              Array.new(without_cycle.first.game_range.max, 0)
            else
              Array.new(stages.last)
            end
    stage
  end

  # Calculate stage and add to stages
  def calculate_stage(game, stage)
    game.cycle = self
    game.result.each { |result| stage[result - 1] += 1 }
    stages << stage
  end
end
