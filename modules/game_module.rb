module GameModule
  def self.add_game(collection)
    game_data = {}

    loop do
      print 'Does this game have multiplayer? (Y/N): '
      game_data[:multiplayer] = gets.chomp.to_s.capitalize
      break if %w[Y N].include?(game_data[:multiplayer])

      puts 'Invalid input. Please enter Y or N.'
    end

    loop do
      print 'When was the last time you played it? (YYYY-MM-DD): '
      game_data[:last_played_at] = gets.chomp
      break if /\d{4}-\d{2}-\d{2}/.match?(game_data[:last_played_at])

      puts 'Invalid date format. Please enter YYYY-MM-DD.'
    end

    collection << Game.new(game_data[:multiplayer] == 'Y', game_data[:last_played_at])
    write_games_to_json(collection)

    puts 'Game created succesfully. [Press ENTER to continue]'
    gets.chomp
  end

  def self.list_all_games(collection)
    if collection.empty?
      puts 'Please, create a GAME. [Press ENTER to continue]'
      gets.chomp
    else
      puts 'Games'
      puts '-----------------------------'
      collection.each do |game|
        puts "Multiplayer: #{game.multiplayer}, Last Played At: #{game.last_played_at}"
      end
      puts '-----------------------------'
    end
  end

  def self.load_games_from_json(collection, filename = 'json/games.json')
    return unless File.exist?(filename)

    data = JSON.parse(File.read(filename))
    data.each do |game_data|
      game = Game.new(
        game_data['multiplayer'],
        game_data['last_played_at']
      )
      collection << game
    end
  end

  def self.write_games_to_json(collection, filename = 'json/games.json')
    games_data = collection.map do |game|
      {
        'multiplayer' => game.multiplayer,
        'last_played_at' => game.last_played_at
      }
    end

    File.write(filename, JSON.pretty_generate(games_data))
  end
end
