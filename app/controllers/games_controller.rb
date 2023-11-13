require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('a'..'z').to_a.sample }
  end

  def score
    submitted_word = params[:word]
    original_letters = params[:letters]

    if valid_word?(submitted_word, @letters)
      if valid_english_word?(submitted_word)
        @result = "Congratulations! #{submitted_word} is a valid English word."
      else
        @result = "#{submitted_word} is not a valid English word."
      end
    else
      @result = "#{submitted_word} can't be built out of the original grid."
    end
  end

  private

  def valid_word?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def valid_english_word?(word)
    response = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{word}").read)
    response['found']
  end
end
