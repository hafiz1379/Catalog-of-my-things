require_relative 'item'

class Genre
  attr_accessor :name

  def initialize(name)
    @id = Random.rand(1..1000)
    @name = name
    @items = []
  end

  def add_item(new_item)
    return if new_item.genre

    new_item.genre = self
    @items << new_item
    @items
  end

  private

  attr_reader :id, :items
end
