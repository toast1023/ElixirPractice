defmodule HiLowGame do
	def play do
		myNum = :rand.uniform(100)
		IO.puts("Welcome!")
		# IO.gets returns a string, need to parse it into integer
		guess = IO.gets("Guess the number: ")
		# parsing it into an intger returns a tuple {integer, /n}
		guess = Integer.parse(guess)
		# gets the first element of the tuple, or index 0
		guess = elem(guess,0)
		# keep track of a total state
		total = 0
		attempt(guess,myNum,total)
	end

	def attempt(myNum,myNum,total) do
		total = total + 1
		IO.puts("You've guessed the correct number!")
		IO.puts("You made #{total} guesses")
	end

	def attempt(wrong,myNum,total) do
		if wrong > myNum do
			IO.puts("Number is lower")
			total = total + 1 
			guess = IO.gets("Try Again: ")
			guess = Integer.parse(guess)
			guess = elem(guess,0)
			attempt(guess, myNum, total)
		else
			IO.puts("Number is higher")
			total = total + 1
			guess = IO.gets("Try again: ")
			guess = Integer.parse(guess)
			guess = elem(guess,0)
			attempt(guess, myNum, total)
		end
	end
end