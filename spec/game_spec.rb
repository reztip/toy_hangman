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

  	# context "#welcome_message" do
  	# 	it "welcomes the player" do
  	# 		game = Game.new
  	# 		game.stub(:welcome_message) {"Welcome to hangman!"}
  	# 		expect(game.welcome_message).to eq "Welcome to hangman!"
  	# 	end
  	# end

  	context "#game_over?" do
  		it "knows the game is over if there are no guesses left" do
  			game = Game.new
  			game.instance_variable_set(:@guesses, 0)
  			expect(game.game_over?).to eq true
  		end

  		it "knows the game is not over if there are guesses left" do
  			game = Game.new
  			expect(game.represent_word).not_to eq game.word
  			expect(game.game_over?).to be false
  		end

  		it "knows the game is not over if the word representation is not equal to the actual word" do
  			game = Game.new
  			game.stub(:represent_word) {"pot_to"}
  			game.instance_variable_set(:@word, "potato")
  			expect(game.game_over?).to be false
  		end

  		it "knows the game is over if represent_word == @word" do
  			game = Game.new
  			game.stub(:represent_word) {"potato"}
  			game.instance_variable_set(:@word, "potato")
  			expect(game.game_over?).to be true
  		end
  	end

  	context "#represent_word" do
  		it "gives an empty representation after intialization" do
  		  game = Game.new
  		  puts game.represent_word
  		  expect(game.represent_word).to eq ("_"*game.word.length)
  		end
  	end

  	context "#handle_guess" do
  	  it "Fills out the correct letters if the user guesses correctly." do
  	  	game = Game.new
  	  	game.instance_variable_set(:@word, "potato")
  	  	game.handle_guess('o')
  	  	expect(game.represent_word).to eq "_o___o"
  	  	game.handle_guess('t')
  	  	expect(game.represent_word).to eq "_ot_to"
  	  end

  	  it "decrements the number of guesses if the user guesses incorrectly" do
  	  	game = Game.new
  	  	game.instance_variable_set(:@word, "potato")
  	  	game.instance_variable_set(:@guesses, 5)
  	  	game.handle_guess('e')
  	  	expect(game.guesses).to eq 4
  	  end
  	end

	
  end
end