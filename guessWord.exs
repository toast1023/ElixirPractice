# guess word game for bread

hints = "flour, water, yeast, bakery" 
# String interpolation operator, puts everything from hints into the operator
IO.puts("Hints: #{hints}")

# user input
guess = IO.gets("Guess the word: ")

# For developer, see state of variable
# String trim removes the \n at the back of the string
IO.inspect(String.trim(guess))

guess = String.trim(guess)

# compare a value against many patterns until we find matching one
case guess do
	"hello" ->
		IO.puts("Hello!")
	"bread" ->
		IO.puts("Won!")
	# underscore matches any value
	# if want to match against existing variable need to use ^ to get value of variable
	_wrong->
		IO.puts("Lost!")
end