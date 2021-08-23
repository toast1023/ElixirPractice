filename = IO.gets("File to count the words from (h for help):\n")
		|> String.trim()

#can also use heredocs """ to write this instead of <>
if (filename =="h") do
	IO.puts(~s<
		Usage: [filename] -[flags]
		Flags
		-l		display line count
		-c		display character count
		-w		display word count(default)
		Multiple flags may be used. Example usage to display line and character count:

		somefile.txt -lc
		["somefile.txt ", "lc"]
	>)
else 
	parts = String.split(filename, " -")
	# List.first gets first element of list
	filename = List.first(parts) 
			|> String.trim
	# Enum.at() gets nth element, starting at 0
	flags = case Enum.at(parts, 1) do
		# no flags
		nil		-> ["w"]
		# split(something,"") splits into individual characters, then filters out empty characters
		chars	-> String.split(chars,"") |> Enum.filter(fn x -> x != "" end)
	end

	body=File.read!(filename)
	# Windows uses \r\n to denote new line, Linux and Unix use \n, Mac OS use \r
	lines = String.split(body, ~r{\r\n|\n|\r})
	# \\n matches against newline character
	words = String.split(body, ~r{\\n|[^\w']+})
		 |> Enum.filter(fn x->x != "" end)
	chars = String.split(body,"") 
		 |> Enum.filter(fn x->x != "" end)

	# Enum.each executes a function you give it on each item in the list/map/enumerable thing you give it
	Enum.each(flags, fn flag ->
		case flag do
			"l"	-> IO.puts("Lines: #{Enum.count(lines)}")
			"w" -> IO.puts("Words: #{Enum.count(words)}")
			"c" -> IO.puts("Chars: #{Enum.count(chars)}")
			_ 	-> nil
		end
	end)
end