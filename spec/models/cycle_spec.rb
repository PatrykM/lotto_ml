require 'rails_helper'

RSpec.describe Cycle, type: :model do
  
  describe "Find a cycle" do
  	let(:lotto_game) { LottoGame.new }
		let(:lotto_results_file) { 'spec/files/lotto_one_cycle.csv' }
		let(:lotto_import) { ImportResult.new(lotto_results_file,lotto_game) }
    let(:unfinished_stage) {
      [
        1, 1, 1, 2, 1, 1, 1, 1, 3, 2, 1, 1, 1, 3, 2, 
        2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 
        1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 
        1, 1, 1, 1
      ]  
    }

  	it "#find_new" do
			lotto_import.import
			Cycle.new.find_new(LottoGame.without_cycle)
  		expect(LottoGame.without_cycle.count).to eq 0
  	end

    context "with unfinished cycles" do
      
      before do 
        create :unfinished_cyle_lotto_game
        create :unfinished_cyle_multi_game
        create :finished_cycle_lotto_game
        create :finished_cycle_multi_game
      end

      it ".unfinished returns unfinished cyle for a LottoGame game type" do
        expect(Cycle.unfinished(LottoGame).stages.last).to eq unfinished_stage
      end

      it ".unfinished returns unfinished cyle for a MultiGame game type" do
        expect(Cycle.unfinished(MultiGame).stages.last).to eq Array.new(80,0).fill(1,0..78)
      end

      it "finds unfinished cycle in LottoGame and adds games to it" do
        create(:lotto_game, draw_date: "2000-01-01", result:[1,2,3,4,5,6])
        Cycle.find_in_games(LottoGame)
        expect(Cycle.unfinished(LottoGame).stages.last).to eq [2, 2, 2, 3, 2, 2, 1, 1, 3, 2, 1, 1, 1, 3, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1]
      end

      it "finds unfinished cycle in LottoGame adds games to it and finish it" do
        create(:lotto_game, draw_date: "2000-01-01", result:[41,42,43,44,45,46])
        create(:lotto_game, draw_date: "2000-01-02", result:[1,2,3,4,5,6])
        
        Cycle.find_in_games(LottoGame)
        #byebug
        expect(Cycle.unfinished(LottoGame).stages.last).to eq Array.new(49,0).fill(1,0..5)
      end

      it "finds unfinished cycle in LottoGame and adds games to it" do
        create(:multi_game, draw_date: "2000-01-01", result:Array.new(20) {|i| i+1})

        Cycle.find_in_games(MultiGame)
        expect(Cycle.unfinished(MultiGame).stages.last).to eq Array.new(80,0).fill(1,0..78).fill(2,0..19)
      end

      it "finds unfinished cycle in LottoGame adds games to it and finish it" do
        create(:multi_game, draw_date: "2000-01-01", result:Array.new(20) {|i| i+1})
      end

    end
  end
end
