filename = IO.gets("Enter file name: ") 
		|> String.trim()
body = File.read!(filename)
words = body 
# regular expressions (~r) 
#(\w) matches each word character
#([^\w]) matches everything not NOT word characters, but we get a lot of empty strings because multiple non-word characters in a row
#([^\w]+) match one or more, and gets as many NOT word characters as it can
#\\n matches against newline character
# [^\w']+ stop matches against apostrophes as well
		|> String.split(~r{\\n|[^\w']+}) 
		|> Enum.filter(fn x-> x != "" end)
		|> Enum.count()
# filter only returns elements for which the function(fn) returns true
# Enum.count() counts number of words
IO.inspect words


# (thing1|thing2)+  things1 OR thing2 