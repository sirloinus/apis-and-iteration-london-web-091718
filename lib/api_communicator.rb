require 'rest-client'
require 'json'
require 'pry'

require_relative "../lib/command_line_interface.rb"

def get_character_books_from_api(character)
  #make the web request
  response_string = RestClient.get('https://anapioficeandfire.com/api/characters/')
  response_hash = JSON.parse(response_string)

  # NOTE: in this demonstration we name many of the variables _hash or _array.
  # This is done for educational purposes. This is not typically done in code.
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

  #get array of books require_relative
  books_urls = []
  response_hash.each do |got_character|
    if got_character["name"].downcase == character
      books_urls << got_character["books"]
    end
  end
  books_urls
end

def print_books(books_urls)
  # some iteration magic and puts out the movies in a nice list
  #parse Book Title from book url
  book_titles = []
  books_urls.flatten.each do |url|
    response_book = RestClient.get(url)
    book_hash = JSON.parse(response_book)
    book_titles << book_hash["name"]
  end
  puts book_titles
end

def show_character_books(book)
  books_urls = get_character_books_from_api(book)
  print_books(books_urls)
end

##################   BONUS

def get_characters_from_book_api(book)
  response_books = RestClient.get('https://anapioficeandfire.com/api/books/')
  book_hash = JSON.parse(response_books)
  #create array of characters' urls
  characters_urls = []
  book_hash.each do |got_books|
    if got_books["name"].downcase == book
      characters_urls << got_books["characters"]
    end
  end
  characters_urls
end

def print_characters(characters_urls)
  characters = []
  characters_urls.flatten.each do |url|
    response_character = RestClient.get(url)
    character_hash = JSON.parse(response_character)
    if !!character_hash["name"]
      characters << character_hash["name"]
    else
      characters << character_hash["aliases"]
    end
  end
  puts characters
end

def show_character_in_a_book(book)  #ask user for name of book, return a list of all the characters in the book
  characters_urls = get_characters_from_book_api(book)
  print_characters(characters_urls)
end
