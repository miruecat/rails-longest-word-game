require "open-uri"
class GamesController < ApplicationController
  VOWELS = ["a", "e", "i", "u", "o", "y"]
  def new
    # @letters = ('a'..'z').to_a.sample
    #select vowels
    @letters = Array.new(5) { VOWELS.sample }
    #select consonants
    @letters += Array.new(5) { (('a'..'z').to_a - VOWELS).sample }
    #randomly select 5 of each
    #push into an array
    @letters.shuffle!
  end
  def score
    @letters = params[:letters]
    @word = params[:word]
    @english_word = english_word?(@word)
    @match_letters = match_letters(@letters, @word)
  end
  def english_word?(word)
  response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  json['found']
  end
  def match_letters(letters, word)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
