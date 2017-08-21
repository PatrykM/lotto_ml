require 'rails_helper'

RSpec.describe LottoGame, type: :model do
  let(:lotto_game) { LottoGame.new }
	let(:game_range) { (1..49) }
	let(:game_format) { 7 }

	it "has a valid game range" do
		expect(lotto_game.game_range).to eq game_range
	end

	it "has a valid game format" do
		expect(lotto_game.game_format).to eq game_format
	end

  describe "create new LottoGame object" do
  	
  	it "creates valid LottoGame object" do
  		LottoGame.create(draw_date: "1996-04-15", result: [1,7,22,34,15,6]) 		
  		expect(LottoGame.all.count).to eq 1
  	end

  	it "doesn't create results with numbers outside of the LottoGame range" do
      LottoGame.create(draw_date: "1957-01-28", result: [1,7,22,34,15,61])
      expect(LottoGame.all.count).to eq 0
    end

    it "doesn't create results with incorect LottoGame result size" do
      LottoGame.create(draw_date: "1957-01-28", result: [1,7,22,34,15,6,12])
      expect(LottoGame.all.count).to eq 0
    end

    it "doesn't allow to create duplicates" do
    	LottoGame.create(draw_date: "1996-04-15", result: [1,7,22,34,15,6])
    	LottoGame.create(draw_date: "1996-04-15", result: [1,7,22,34,15,6]) 		
    	expect(LottoGame.all.count).to eq 1
    end

    it "allows to create LottoGame with same results and different draw date" do
    	LottoGame.create(draw_date: "1996-04-15", result: [1,7,22,34,15,6])
    	LottoGame.create(draw_date: "1996-04-16", result: [1,7,22,34,15,6]) 		
    	expect(LottoGame.all.count).to eq 2
    end
  end
end
