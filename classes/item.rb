require 'securerandom'
require 'date'

class Item
  attr_accessor :author, :label, :publish_date, :published_date
  attr_reader :id, :archived, :genre, :archivedtoo

  def initialize(params = {})
    @id = SecureRandom.hex(2)
    @author = params[:author]
    @label = params[:label]
    @publish_date = parse_date(params[:publish_date])
    @archived = false
    @published_date = published_date
    @archivedtoo = false
  end

  def initializetoo(published_date:)
    @id = id || Random.rand(1..1000)
    @published_date = published_date
    @archived = false
  end

  def move_to_archive
    @archived = true if can_be_archived?
    @archivedtoo = true if can_be_archivedtoo?
  end

  # Method that adds genre and updates the reference in the genre object
  def genre=(new_genre)
    @genre = new_genre
    new_genre.add_item(self)
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

  def parse_date(date_string)
    return nil unless date_string

    begin
      Date.strptime(date_string, '%Y-%m-%d')
    rescue Date::Error
      # Silenciosamente establece la fecha de publicación a nil
      nil
    end
  end

  def can_be_archived?
    Time.now.year - @publish_date.year > 10
  end

  def can_be_archivedtoo?
    (Date.today - @published_date).to_i >= 3650
  end
end
