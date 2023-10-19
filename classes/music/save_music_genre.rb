require_relative '../music_album'
require_relative '../genre'
require 'json'

def save_music_albums
  music_albums_arr = []
  @music_albums.each do |music_album|
    music_albums_arr.push({ published_date: music_album.published_date, on_spotify: music_album.on_spotify })
  end
  File.write('json/music_albums.json', music_albums_arr.to_json) if @music_albums.any?
end

def save_genres
  genres_arr = []
  @genres.each do |genre|
    genres_arr.push({ name: genre.name })
  end
  File.write('json/genres.json', genres_arr.to_json) if @genres.any?
end
