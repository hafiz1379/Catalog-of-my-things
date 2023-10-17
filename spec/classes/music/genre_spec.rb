require_relative '../../../classes/genre'
require_relative '../../../classes/item'
require 'date'

RSpec.describe Genre do
  describe '#initialize' do
    it 'Creates a genre with the given name' do
      genre = Genre.new('Horror')
      expect(genre.name).to eq('Horror')
    end
  end

  describe '#add_item' do
    it 'Adds a new item to the genre' do
      genre = Genre.new('Racing')
      item = Item.new(published_date: Date.new(2020, 1, 1))
      items = genre.add_item(item)
      expect(items).to include(item)
    end
  end
end
