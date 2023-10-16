require 'date'
require_relative '../../../classes/game/game'

describe Game do
  context 'while providing good information' do
    it 'using the can_be_archived? method to be private' do
      date = DateTime.now.to_date
      game = Game.new(true, date)

      expect { game.send(:can_be_archived?) }.to raise_error(NoMethodError)
    end
  end
end
