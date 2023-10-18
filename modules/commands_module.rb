module Commands
  def self.clear_screen
    system('clear') || system('cls')
  end
end
