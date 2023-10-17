require_relative '../../../classes/music_album'
require_relative '../../../classes/genre'
require_relative '../../../classes/music/load_music_genre'
require 'json'

RSpec.describe 'Load Music Albums and Genres' do
  describe '#load_music_albums' do
    it 'Loads music albums from JSON file' do
      music_albums_data = [
        { 'published_date' => '2023-01-01', 'on_spotify' => true },
        { 'published_date' => '2022-02-02', 'on_spotify' => false }
      ]
      allow(File).to receive(:read).with('json/music_albums.json').and_return(music_albums_data.to_json)

      music_albums = load_music_albums

      expect(music_albums.length).to eq(2)
      expect(music_albums[0].published_date).to eq(Date.parse('2023-01-01'))
      expect(music_albums[0].on_spotify).to eq(true)
      expect(music_albums[1].published_date).to eq(Date.parse('2022-02-02'))
      expect(music_albums[1].on_spotify).to eq(false)
    end

    it 'Returns an empty array if file is not found' do
      allow(File).to receive(:read).with('json/music_albums.json').and_raise(Errno::ENOENT)

      music_albums = load_music_albums

      expect(music_albums).to be_empty
    end
  end

  describe '#load_genre' do
    it 'Loads genres from JSON file' do
      genres_data = [
        { 'name' => 'NuMetal' },
        { 'name' => 'Blues' }
      ]
      allow(File).to receive(:read).with('json/genres.json').and_return(genres_data.to_json)

      genres = load_genre

      expect(genres.length).to eq(2)
      expect(genres[0].name).to eq('NuMetal')
      expect(genres[1].name).to eq('Blues')
    end

    it 'Returns an empty array if file is not found' do
      allow(File).to receive(:read).with('json/genres.json').and_raise(Errno::ENOENT)

      genres = load_genre

      expect(genres).to be_empty
    end
  end
end