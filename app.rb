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
require_relative 'modules/music_album_module'
require_relative 'modules/commands_module'
require 'date'
require 'colorize'

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
      render_ascii_art
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

  def load_books_from_json(filename = 'json/books.json')
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

  def write_books_to_json(filename = 'json/books.json')
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
      Label.new('3', 'Gift', 'magenta')
    ]
  end
  
  def render_ascii_art
    puts '
    ██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗             
    ██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝             
    ██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗               
    ██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝               
    ╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗    ██╗██╗██╗
     ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝    ╚═╝╚═╝╚═╝
                                                                               
    '.green
    puts 'To start, pick an option from the list below (1-10):'.bold
    puts ''
  end

  def display_menu    
    puts '1. Add Book               .'.bold.black.on_light_magenta
    puts '2. Add Music Album        .'.bold.black.on_light_yellow
    puts '3. Add Game               .'.bold.black.on_light_cyan
    puts '4. List All Books         .'.bold.black.on_light_magenta
    puts '5. List All Music Albums  .'.bold.black.on_light_yellow
    puts '6. List All Games         .'.bold.black.on_light_cyan
    puts '7. List All Labels        .'.bold.black.on_light_magenta
    puts '8. List All Genres        .'.bold.black.on_light_yellow
    puts '9. List All Authors       .'.bold.black.on_light_cyan
    puts '10. Exit -----------------.'.bold.white.on_black
  end

  def exit_app
    puts 'Thanks for using the app!       '.bold.white.on_green
    puts 'Developed by: Hafiz - Jhon - JD '.bold.white.on_green
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

    unless @genres.empty?
      puts 'List of all genres:'.bold.black.on_light_yellow
      puts '-----------------------------'.black.on_light_yellow
      @genres.each_with_index do |genre, index|
        puts "#{index + 1}. #{genre.name}"
      end
      puts '-----------------------------'.black.on_light_yellow
      puts '[Press ENTER to continue]'
      gets.chomp
    end
  end

  def add_game
    GameModule.add_game(@games)
  end

  def list_all_games
    Commands.clear_screen
    GameModule.list_all_games(@games)
    Commands.clear_screen
  end

  def list_all_authors
    Commands.clear_screen
    AuthorModule.list_all_authors(@authors)
    Commands.clear_screen
  end

  def list_all_music_albums
    Commands.clear_screen
    MusicAlbumModule.list_all_music_albums(@music_albums)
    Commands.clear_screen
  end

  def add_music_album
    MusicAlbumModule.add_music_album(@music_albums)
    save_music_albums
  end

  def list_all_books
    Commands.clear_screen
    BookModule.list_books(@books)
    Commands.clear_screen
  end

  def list_all_labels
    Commands.clear_screen
    LabelModule.list_labels(@labels)
    Commands.clear_screen
  end
end
