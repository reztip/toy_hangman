module Hangman

	require 'yaml'
	class Game
		attr_reader :word, :guesses, :guess_map
		attr_accessor :guesses
		def initialize(dictionary = "5desk.txt")
			dict = []
			File.open(dictionary, "r").each_line do |line|
				dict << line if line.length.between?(6,14)
			end
			@@dictionary = dict
			reset_game if @word.nil?
		end


		# def play_game
		# 	reset_game
		# 	welcome_message
		# 	game_loop until game_over?
		# 	return if @saved
		# 	play_again = handle_game_over(['y', 'yes'])
		# 	play_again ?  play_game : "Goodbye."
		# end

		def reset_game
			@word = @@dictionary.sample.downcase[0..-3] #strips away \r and \n characters
			@guesses = 5
			@guess_map = Array.new(@guesses) {false}
			# puts @guess_map
		end

		# def game_loop
		# 	# puts @word
			
		# 	puts "If you would like to save the game, enter 1. If you would like to load a game, enter 2. Else press enter."
		# 	choice = $stdin.gets.chomp.strip.to_i
		# 	if choice == 1
		# 		puts "Choose a filename. If none, the file name will be called saved_game.txt"
		# 		fname = $stdin.gets.chomp
		# 		Hangman.save!(fname, self)
		# 		puts "Goodbye."
				
		# 	elsif choice == 2
		# 		puts "Enter a filename to load."
		# 		fname = $stdin.gets.chomp
		# 		Hangman.load(fname)
		# 	end

		# 	puts "You have #{@guesses} guesses left."
		# 	puts "Your word currently looks like: #{represent_word}"
		# 	print "please enter a letter: "
		# 	# puts ""
		# 	letter = sanitize_guess($stdin.gets.chomp.strip)
		# 	handle_guess(letter)

		# end
		def game_over?
			return true if (@guesses <= 0 || represent_word == @word || @saved)
			false
		end

		def represent_word
			#if letter is guessed correctly, give the letter in the representation.
			@word.split('').each_with_index.map { |word, index|  @guess_map[index] ? word : "_" }.join('')
		end

		def sanitize_guess(letter)
			if ( !('a'..'z').include?(letter.downcase) )
			  print "Try again, with a letter please: "
			  x = $stdin.gets.chomp
			  # puts x
			  return sanitize_guess(x)

			else
			  # puts letter
			  return letter
			end
		end

		def handle_guess(letter)
		  # puts letter
		  if @word.include?(letter)
  		  	@word.split('').each_with_index do |char, index|
  		  		if char == letter
  		  		  @guess_map[index] = true
  		  		end
  		  	end
  		  else
  		  	@guesses -= 1
  		  end
		end

		def handle_game_over(acceptable_answers)
			(@guesses <= 0) ? (puts "You lost. sorry. The word was #{@word}.") : (puts "You win!")
			puts "Play again? (Yes/No)"
			user_answer = $stdin.gets.chomp.strip.downcase
			acceptable_answers.include?(user_answer) ? true : false
		end

		

		
	end

end