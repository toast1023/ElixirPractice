# Recursion endless version of the guessWord game, where game ends only when player gets word right
defmodule Game do
	def play do
		hints = "flour, water, yeast, bakery" 
		IO.puts("Hints: #{hints}")

		guess = IO.gets("Guess the word: ")
		guess = String.trim(guess)

		attempt(guess)
	end

	# Correct guess function
	def attempt("bread") do
		IO.puts("You've won! Congratulations!")
	end

	def attempt(wrong_guess) do
		IO.puts("#{wrong_guess} is not correct")

		guess = IO.gets("Try again: ")
		guess = String.trim(guess)

		attempt(guess)
	end 
end