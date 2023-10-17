require_relative '../../../app'
require_relative '../../../classes/music/save_music_genre'
require 'json'

RSpec.describe App do
  before do
    @app = App.new
    @music_albums = []
    @genres = []
    allow(@app).to receive(:music_albums).and_return(@music_albums)
    allow(@app).to receive(:genres).and_return(@genres)
  end

  describe '#save_music_albums' do
    it 'Saves music_albums to JSON file' do
      allow(File).to receive(:write)
      expect_any_instance_of(App).to receive(:save_music_albums)
      @app.save_music_albums
    end
  end
end
