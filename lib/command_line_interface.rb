

def welcome
  'Hey, how are you? Welcome to to Star Wars Fan Database'
end

def get_character_from_user
  puts "please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  character = gets.chomp.downcase
end

def get_book_from_user
  puts "please enter a book"
  book = gets.chomp.downcase
end
