require 'date'
require 'securerandom'

class Item
  attr_accessor :genre, :author, :label, :publish_date
  attr_reader :id, :archived

  def initialize(params = {})
    @id = SecureRandom.hex(2)
    @genre = params[:genre]
    @author = params[:author]
    @label = params[:label]
    @publish_date = (Date.strptime(params[:publish_date], '%d-%m-%Y') if params[:publish_date])
    @archived = false
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  # Method that adds genre and updates the reference in the genre object
  def add_genre(genre)
    @genre = genre
    genre.items.push(self) unless genre.items.include?(self)
  end

  # Method that adds author and updates the reference in the author object
  def add_author(author)
    @author = author
    author.add_item(self) unless author.items.include?(self)
  end

  # Method that adds label and updates the reference in the label object
  def add_label(label)
    @label = label
    label.items.push(self) unless label.items.include?(self)
  end

  private

  def can_be_archived?
    Time.now.year - @publish_date.year > 10
  end
end
