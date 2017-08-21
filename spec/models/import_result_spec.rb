require 'rails_helper'

RSpec.describe ImportResult, type: :model do
  # Testing #import method
  describe '#import' do
    let(:lotto_game) { LottoGame.new }
    let(:multi_game) { MultiGame.new }
    let(:lotto_results_file) { 'spec/files/lotto_results.csv' }
    let(:multi_results_file) { 'spec/files/multi_results.csv' }
    let(:lotto_import) { ImportResult.new(lotto_results_file, lotto_game) }
    let(:multi_import) { ImportResult.new(multi_results_file, multi_game) }

    it 'imports lotto game result' do
      lotto_import.import
      expect(LottoGame.all.count).to eq 24
    end

    it 'imports multi game result' do
      multi_import.import
      expect(MultiGame.all.count).to eq 26
    end

    it "doesn't import duplicates on lotto game" do
      LottoGame.create(draw_date: '1957-01-27', result: [8, 12, 31, 39, 43, 45])
      LottoGame.create(draw_date: '1957-05-05', result: [2, 4, 11, 18, 25, 48])
      lotto_import.import
      expect(LottoGame.all.count).to eq 24
    end

    it "doesn't import duplicates on multi game" do
      MultiGame.create(draw_date: '1996-04-15', result: [2, 10, 14, 16, 25, 27, 28, 29, 30, 31, 32, 41, 43, 45, 49, 60, 61, 62, 69, 71])
      MultiGame.create(draw_date: '1996-04-25', result: [2, 8, 15, 16, 25, 27, 29, 32, 34, 38, 40, 45, 47, 53, 57, 58, 62, 63, 69, 74])
      multi_import.import
      expect(MultiGame.all.count).to eq 26
    end
  end
end
