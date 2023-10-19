require_relative '../../../classes/music_album'
require 'date'

RSpec.describe MusicAlbum do
  let(:published_date) { Date.new(2000, 1, 1) }

  describe 'when creating a new MusicAlbum' do
    it 'has the correct published_date and on_spotify attributes' do
      album = MusicAlbum.new(published_date: published_date, on_spotify: true)
      expect(album.published_date).to eq(published_date)
      expect(album.on_spotify).to be true
    end

    it 'defaults on_spotify attribute to false' do
      album = MusicAlbum.new(published_date: published_date)

      expect(album.on_spotify).to be false
    end
  end

  describe 'can_be_archived? method' do
    it 'returns false if not on Spotify' do
      album = MusicAlbum.new(published_date: published_date, on_spotify: false)
      expect(album.on_spotify).to be false
    end

    it 'returns true if on Spotify and can be archived' do
      album = MusicAlbum.new(published_date: published_date, on_spotify: true)
      expect(album.on_spotify).to be true
    end
  end
end
