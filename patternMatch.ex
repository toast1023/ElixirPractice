defmodule PatternMatch do
	# as long as keys match pattern match will function
	# PatternMatch.mapping(%{"key" => "hello what is up I am hungry"})
	def mapping(%{"key" => value}) do
		IO.puts value
	end
end