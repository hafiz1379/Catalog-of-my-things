require 'date'
require_relative '../../../classes/author/author'
require_relative '../../../classes/game/game'

describe Author do
  context 'while providing good information' do
    it 'using the add_item method with a game item' do
      date = DateTime.now.to_date
      game = Game.new(true, date)
      author = Author.new(1, 'John', 'Palacios')
      author.add_item(game)

      expect(author.items).to include(game)
    end
  end
end
