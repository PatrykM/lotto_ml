require 'rails_helper'

RSpec.describe MultiGame, type: :model do
  let(:multi_game) { MultiGame.new }
  let(:game_range) { (1..80) }
  let(:game_format) { 21 }

  it 'has a valid game range' do
    expect(multi_game.game_range).to eq game_range
  end

  it 'has a valid game format' do
    expect(multi_game.game_format).to eq game_format
  end

  describe 'create new MultiGame object' do
    it 'creates valid MultiGame object' do
      MultiGame.create(draw_date: '1996-04-15', result: [2, 10, 14, 16, 25, 27, 28, 29, 30, 31, 32, 41, 43, 45, 49, 60, 61, 62, 69, 71])
      expect(MultiGame.all.count).to eq 1
    end

    it "doesn't create results with numbers outside of the MultiGame range" do
      MultiGame.create(draw_date: '1957-01-28', result: [2, 10, 14, 16, 25, 27, 28, 29, 30, 31, 32, 41, 43, 45, 49, 60, 61, 62, 69, 81])
      expect(MultiGame.all.count).to eq 0
    end

    it "doesn't create results with incorect MultiGame result size" do
      LottoGame.create(draw_date: '1957-01-28', result: [2, 10, 14, 16, 25, 27, 28, 29, 30, 31, 32, 41, 43, 45, 49, 60, 61, 62, 69])
      expect(MultiGame.all.count).to eq 0
    end

    it "doesn't allow to create duplicates" do
      MultiGame.create(draw_date: '1996-04-15', result: [2, 10, 14, 16, 25, 27, 28, 29, 30, 31, 32, 41, 43, 45, 49, 60, 61, 62, 69, 71])
      MultiGame.create(draw_date: '1996-04-15', result: [2, 10, 14, 16, 25, 27, 28, 29, 30, 31, 32, 41, 43, 45, 49, 60, 61, 62, 69, 71])
      expect(MultiGame.all.count).to eq 1
    end

    it 'allows to create MultiGame with same results and different draw date' do
      MultiGame.create(draw_date: '1996-04-17', result: [2, 10, 14, 16, 25, 27, 28, 29, 30, 31, 32, 41, 43, 45, 49, 60, 61, 62, 69, 71])
      MultiGame.create(draw_date: '1996-04-16', result: [2, 10, 14, 16, 25, 27, 28, 29, 30, 31, 32, 41, 43, 45, 49, 60, 61, 62, 69, 71])
      expect(MultiGame.all.count).to eq 2
    end
  end

  describe 'cycle' do
    it 'returns MultiGame results without cycle assigned' do
      create :multi_game
      create :multi_game_with_cycle
      expect(MultiGame.without_cycle.count).to eq 1
    end
  end
end
