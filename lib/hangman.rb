require_relative "hangman/version"

module Hangman
  # Your code goes here...
end		
require_relative "./hangman/game.rb"
game = Hangman::Game.new
game.play_game
