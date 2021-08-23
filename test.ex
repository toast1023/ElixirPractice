# Defining a module, have to be capitalized 
defmodule FuncTutorial do
	# declaring a named function
	def hello(passThingIn) do
		# return last value assigned/evaluated, so in this case passThingIn
		"Hello world"
		passThingIn
		# c("filename") to compile module
	end

	# Pass in filename to be read
	def readFile(filename) do
		File.read(filename)
		# Result: {:ok, "Look I am a text file!"}
	end
end