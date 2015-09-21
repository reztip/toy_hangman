module Hangman
	class Game
		attr_reader :dictionary, :word
		def initialize(dictionary = "5desk.txt")
			dict = []
			File.open(dictionary, "r").each_line do |line|
				dict << line if line.length.between?(5,12)
			end
			@dictionary = dict
			@word = @dictionary.sample.downcase
			@guesses = 5
			@guess_map = Array.new(@guesses) {false}

			setup
			game_loop unless game_over?

		end

		private

		def setup
			puts "Welcome to hangman!"
		end

		def game_loop
			puts "You have #{@guesses} guesses left."
			puts "Your word currently looks like: #{represent_word}"
			print "please enter a letter: "
			current_word = handle_guess(gets.chomp)
		end

		def game_over
			return true if (@guesses < 0 || )
		end

		def represent_word
			@
		end

		def handle_guess(letter)
			return "Try again, with a valid character. " if (letter.length != 1)
			letter = letter.downcase
			cur_word = ""
			@guesses.each_with_index do |item, index|
				@guess_map[index] = true if letter == @guesses[index]
				if @guess_map[index]
					cur_word << letter
				else
					cur_word << "_"
				end
			end

			cur_word		


		end
	end
end