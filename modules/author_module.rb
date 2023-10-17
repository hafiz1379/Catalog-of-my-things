module AuthorModule
  def self.list_all_authors(collection)
    if collection.empty?
      puts 'Please, create an AUTHOR. [Press ENTER to continue]'
      gets.chomp
    else
      puts 'Authors'
      puts '-----------------------------'
      collection.each do |author|
        puts "ID: #{author.id}, Name: #{author.first_name} #{author.last_name}, Items(Quantity): #{author.items.size}"
      end
      puts '-----------------------------'
    end
  end
end