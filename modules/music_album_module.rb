module MusicAlbumModule
  def self.add_music_album(collection)
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
    collection << music_album

    puts 'Music album added successfully!'
    puts '------------------'
  end

  def self.list_all_music_albums(collection)
    if collection.empty?
      puts 'Please, create a MUSIC ALBUM. [Press ENTER to continue]'
    else
      puts 'List of Music Albums:'.bold.black.on_light_yellow
      puts '-----------------------------'.black.on_light_yellow
      collection.each_with_index do |album, index|
        next unless album.is_a?(MusicAlbum)

        spotify_status = album.on_spotify ? 'Yes' : 'No'
        puts "#{index + 1}. Published: #{album.published_date}, Archived: #{album.archivedtoo}, Spotify: #{spotify_status}"
      end
      puts '-----------------------------'.black.on_light_yellow
      puts '[Press ENTER to continue]'
    end
    gets.chomp
  end
end
