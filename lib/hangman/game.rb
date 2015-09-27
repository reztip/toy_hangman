module Hangman
	class Game
		attr_reader :dictionary, :word
		def initialize(dictionary = "5desk.txt")
			dict = []
			File.open(dictionary, "r").each_line do |line|
				dict << line if line.length.between?(5,12)
			end
			@dictionary = dict
			@word = @dictionary.sample.downcase[0..-3] #strips away \r and \n characters
			@guesses = 5
			@guess_map = Array.new(@guesses) {false}

			puts welcome_message
			game_loop unless game_over?

		end


		def welcome_message
			"Welcome to hangman!"
		end

		def game_loop
			puts "You have #{@guesses} guesses left."
			puts "Your word currently looks like: #{represent_word}"
			print "please enter a letter: "
			puts ""
			letter = sanitize_guess(gets.chomp)
			handle_guess(letter)

		end

		def game_over?
			return true if (@guesses <= 0 || represent_word == @word)
			false
		end

		def represent_word
			#if letter is guessed correctly, give the letter in the representation.
			@word.split('').each_with_index.map { |word, index|  @guess_map[index] ? word : "_" }.join('')
		end

		def sanitize_guess(letter)
			if ( !('a'..'z').include?(letter.downcase) )
				puts "Try again, with a letter please."
			    sanitize_guess(letter)
			else
				letter
		end

		def handle_guess(letter)
  		  if @word.include?(letter)
  		  	@word.each_with_index do |char, index|
  		  		@guess_map[index] = true if char == letter 
  		  	end
  		  else
  		  	@guess -= 1
  		  end
		end
	end
end