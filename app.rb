require_relative 'classes/book'
require_relative 'modules/book_module'
require_relative 'classes/label'
require_relative 'modules/label_module'
require_relative 'classes/game/game'
require_relative 'modules/game_module'
require_relative 'modules/author_module'
require_relative 'classes/genre'
require_relative 'classes/music_album'
require_relative 'classes/music/load_music_genre'
require_relative 'classes/music/save_music_genre'
require 'date'

class App
  attr_accessor :music_albums, :genres

  def initialize
    initialize_collections
    initialize_actions
    load_books_from_json
    GameModule.load_games_from_json(@games)
  end

  def run
    loop do
      display_menu
      choice = gets.chomp.to_i
      action = @actions[choice]
      if action
        action.call
      else
        puts 'Invalid choice.'
      end
    end
  end

  def find_label_by_title(title)
    @labels.find { |label| label.title == title }
  end

  private

  def load_books_from_json(filename = 'books.json')
    return unless File.exist?(filename)

    data = JSON.parse(File.read(filename))
    data.each do |book_data|
      book = Book.new(
        id: book_data['id'],
        title: book_data['title'], # Asegúrate de que esto esté en tus datos JSON
        publisher: book_data['publisher'],
        cover_state: book_data['cover_state'],
        publish_date: book_data['publish_date'],
        label: find_label_by_title(book_data['label'])
      )
      @books << book
    end
  end

  def write_books_to_json(filename = 'books.json')
    books_data = @books.map do |book|
      {
        'id' => book.id,
        'publisher' => book.publisher,
        'cover_state' => book.cover_state,
        'publish_date' => book.publish_date,
        'label' => book.label&.title
      }
    end

    File.write(filename, JSON.pretty_generate(books_data))
  end

  def initialize_collections
    @books = []
    @music_albums = []
    @games = []
    @labels = initialize_labels
    @genres = []
    @authors = []
    @music_albums = load_music_albums
    @genres = load_genre
  end

  def initialize_actions
    @actions = {
      1 => method(:add_book),
      2 => method(:add_music_album),
      3 => method(:add_game),
      4 => method(:list_all_books),
      5 => method(:list_all_music_albums),
      6 => method(:list_all_games),
      7 => method(:list_all_labels),
      8 => method(:list_all_genres),
      9 => method(:list_all_authors),
      10 => method(:exit_app)
    }
  end

  def initialize_labels
    [
      Label.new('1', 'New', 'Green'),
      Label.new('2', 'Older', 'Yellow'),
      Label.new('3', 'Gift', 'Red')
    ]
  end

  def display_menu
    puts '1. Add Book'
    puts '2. Add Music Album'
    puts '3. Add Game'
    puts '4. List All Books'
    puts '5. List All Music Albums'
    puts '6. List All Games'
    puts '7. List All Labels'
    puts '8. List All Genres'
    puts '9. List All Authors'
    puts '10. Exit'
  end

  def exit_app
    puts 'Goodbye!'
    save_genres
    exit
  end

  def add_book
    if @labels.empty?
      puts 'No labels available. Please add a label first.'
    else
      BookModule.add_book(@books, @genres, @authors, @labels)
      write_books_to_json
    end
  end

  def list_all_genres
    puts 'The list is empty, please create a Genre!' if @genres.empty?
    @genres.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end
    puts '------------------'
  end

  def add_game
    GameModule.add_game(@games)
  end

  def list_all_games
    GameModule.list_all_games(@games)
  end

  def list_all_authors
    AuthorModule.list_all_authors(@authors)
  end

  def list_all_music_albums
    puts 'The list is empty, please create a Music Album!' if @music_albums.empty?
    puts 'List of all music albums:'
    @music_albums.each_with_index do |album, index|
      next unless album.is_a?(MusicAlbum)

      spotify_status = album.on_spotify ? 'Yes' : 'No'
      puts "#{index + 1}. Published: #{album.published_date}, Archived: #{album.archivedtoo}, Spotify: #{spotify_status}"
    end
    puts '------------------'
  end

  def add_music_album
    print 'Enter published date YYYY-MM-DD: '
    date_input = gets.chomp
    begin
      published_date = Date.parse(date_input)
      current_date = Date.today
      difference = (current_date - published_date).to_i / 365

      puts "The album was published #{difference} years ago"
    rescue ArgumentError
      puts 'invalid date format. Please enter the date in YYYY-MM-DD format'
    end

    print 'Is it on Spotify? (true/false): '
    on_spotify = gets.chomp.downcase == 'true'
    music_album = MusicAlbum.new(published_date: published_date, on_spotify: on_spotify)
    music_albums << music_album

    puts 'Music album added successfully!'
    puts '------------------'
  end
  save_music_albums
end

  def list_all_books
    BookModule.list_books(@books)
  end

  def list_all_labels
    LabelModule.list_labels(@labels)
  end
end
