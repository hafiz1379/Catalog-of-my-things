require_relative '../music_album'
require_relative '../genre'
require 'json'
require 'date'

def load_music_albums
  stored_music_albums = begin
    JSON.parse(File.read('json/music_albums.json'))
  rescue StandardError => e
    puts "Error reading 'music_albums.json': #{e.message}"
    []
  end
  music_albums = []
  stored_music_albums.map do |music_album|
    music_albums << MusicAlbum.new(published_date: Date.parse(music_album['published_date']),
                                   on_spotify: music_album['on_spotify'])
  end
  music_albums
end

def load_genre
  stored_genre = begin
    JSON.parse(File.read('json/genres.json'))
  rescue StandardError => e
    puts "Error reading 'genres.json': #{e.message}"
    []
  end
  genres = []
  stored_genre.map do |genre|
    genres << Genre.new(genre['name'])
  end
  genres
end
