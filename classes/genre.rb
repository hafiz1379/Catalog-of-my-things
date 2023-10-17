class Genre
    attr_accessor :name
  
    def initialize(name)
      @id = Random.rand(1..1000)
      @name = name
      @items = []
    end
  
    def add_item(new_item)
      return nil unless new_item.is_a?(Item)
  
      @items << new_item
      new_item.genre = self
    end
  
    private
  
    attr_reader :id, :items
  end