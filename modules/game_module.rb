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
        puts "ID: #{game.id}, Multiplayer: #{game.multiplayer}, Last Played At: #{game.last_played_at}"
      end
      puts '-----------------------------'
    end
  end
end
