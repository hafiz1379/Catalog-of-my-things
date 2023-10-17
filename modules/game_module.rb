module GameModule

  def self.add_game(collection)
    game_data = {}

    print 'Does this game has multiplayer? (Y/N): '
    game_data[:multiplayer] = gets.chomp.to_s.capitalize

    print 'When was the last time you play it? (YY-MM-DD): '
    game_data[:last_played_at] = gets.chomp

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
