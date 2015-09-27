require "spec_helper"
module Hangman
  describe Game do

  	context "#initialize" do
      it "initializes the game with a word" do
        game = Game.new
        game.instance_variable_set(:@word, "potato")
        expect(game.word).to eq "potato"
      end
  	end

  	context "#welcome_message" do
  		it "welcomes the player" do
  			game = Game.new
  			game.stub(:welcome_message) {"Welcome to hangman!"}
  			expect(game.welcome_message).to eq "Welcome to hangman!"
  		end
  	end

  	context "#represent_word" do
  		it "gives an empty representation after intialization" do
  		  game = Game.new
  		  expect(game.represent_word).to eq ("_"*game.word.length)

  		end
  	end

	
  end
end