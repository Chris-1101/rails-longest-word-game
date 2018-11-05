require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (1..10).map do
      ('A'..'Z').to_a[rand(26)]
    end
  end

  def score
    @score = 0
    user_guess = params[:guess].upcase
    grid = params[:letters].gsub(/\s/, ", ")

    msg_correct = "<strong>Congratulations!</strong> #{user_guess} is a valid English word!"
    msg_invalid = "Sorry but <strong>#{user_guess}</strong> does not seem to be a valid English word..."
    msg_notgrid = "Sorry but <strong>#{user_guess}</strong> can't be built out of #{grid}."

    if english_word?(user_guess)
      if in_grid?(user_guess, grid)
        @score = user_guess.length**2
        @message = msg_correct
      else
        @message = msg_notgrid
      end
    else
      @message = msg_invalid
    end

    if session[:score].nil?
      session[:score] = @score
    else
      session[:score] += @score
    end
  end

  def reset
    session[:score] = 0
    redirect_to :new
  end

  private

  def english_word?(attempt)
    endpoint = "https://wagon-dictionary.herokuapp.com/"
    url = endpoint + attempt
    result = JSON.parse(open(url).read)

    return result[:found.to_s]
  end

  def in_grid?(attempt, grid)
    return attempt.upcase.chars.all? do |letter|
      attempt.upcase.chars.count(letter) <= grid.count(letter)
    end
  end
end
