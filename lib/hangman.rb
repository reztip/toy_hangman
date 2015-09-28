require_relative "hangman/version"

module Hangman
  # Your code goes here...
  class Hangman
	  	def initialize(game = Game.new)
	  		@game = game
	  	end
	  def save!(filename = "saved_game.txt", game)
		  begin
		    File.open("saved_games/#{filename}", 'w') { |f| f.write(YAML.dump(game)) }
		    return true
		  rescue
		    puts "Sorry. The game could not be saved."
		    return false
		  end
		end

	  def loadgame(filename = "saved_game.txt")
		  begin
		    return YAML::load(File.open("saved_games/#{filename}", 'r') {|f| f.read})
		  rescue
			"Sorry. Could not load game. Restarting."
			return nil
		  end
	  end

	  def play_game
		  	welcome_message
	  		print "If you would like to load a game, enter 1: "
	  		input = $stdin.gets.chomp.to_i
	  		loaded = false
	  		if input == 1
	  			print "Enter a filename: "
	  			input = $stdin.gets.chomp
	  			game = loadgame(input)
	  			@game = game if game
	  			loaded = true
	  		end
			@game.reset_game unless loaded
			
			game_loop until @game.game_over?
			play_again = @game.handle_game_over(['y', 'yes'])
			play_again ?  play_game : "Goodbye."
		end

	  def welcome_message
			puts "Welcome to hangman!"
			puts "Your word has a length of #{@game.word.length}."
			# "Would you like to play? Y/N"
	  end

	  def game_loop
				# puts @word
		puts "Your word currently looks like: #{@game.represent_word}"	
		puts "If you would like to save the game and quit, enter 2. Else press enter."
		choice = $stdin.gets.chomp.strip.to_i
		if choice == 2
			puts "Choose a filename. If none, the file name will be called saved_game.txt"
			fname = $stdin.gets.chomp
			fname = "saved_game.txt" if fname == nil
			save!(fname, @game)
			puts "Goodbye."
			exit
		end

		puts "You have #{@game.guesses} guesses left."
		puts "Your word currently looks like: #{@game.represent_word}"
		print "please enter a letter (or 3 to quit): "
		# puts ""
		input = $stdin.gets.chomp.strip
		exit if input.to_i == 3
		letter = @game.sanitize_guess(input)
		@game.handle_guess(letter)

	  end

  end



end		
require_relative "./hangman/game.rb"
hangman = Hangman::Hangman.new
hangman.play_game
