class Author
  attr_accessor :first_name, :last_name
  attr_reader :items

  def initialize(id, first_name, last_name, items = [])
    @first_name = first_name
    @last_name = last_name
    @items = items
    @id = id
  end

  def add_item(item)
    @items << item
    item.author = self
  end
end
