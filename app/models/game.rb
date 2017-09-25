# Generic Game class
class Game
  include Mongoid::Document
  field :draw_date, type: DateTime
  field :result, type: Array
  belongs_to :cycle, optional: true
  has_and_belongs_to_many :neural_networks

  scope :by_ids, ->(ids) { where(:id.in => ids).order_by(draw_date: 'asc') }

  validates_presence_of :draw_date, :result
  # Duplication of the results.
  validates :result, uniqueness: { scope: :draw_date }

  # Custom validations
  validate :result_is_in_range, :result_length

  # Result numbers are in game range
  def result_is_in_range
    errors.add(:result, 'Nieprawidłowe liczby w losowaniu') unless result.all? { |res| game_range.include?(res) }
  end

  # Result has valid lenght
  def result_length
    errors.add(:result, 'Nieprawidłowa ilość liczb w losowaniu') if result.length != draw_count
  end

  # Game format - how long are data. To implement
  def game_format; end

  # Game range - range of numbers used in the game. To implement
  def game_range; end

  # Game draw count
  def draw_count
    game_format - 1
  end

  # Return games not assigned to any cycle and sort them by game date
  def self.without_cycle
    where(:cycle_id.exists => false).order_by(draw_date: 'asc').to_a
  end
end
