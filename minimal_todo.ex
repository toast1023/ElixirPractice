defmodule MinimalTodo do
	@bom :unicode.encoding_to_bom(:utf8)
	def start do
		input = IO.gets("Do you want to create a new .csv? (y/n)\n")
			|> String.trim()
			|>String.downcase()
		case input do
			"y"		-> create_initial_todo() |> get_command()
			"n"		-> load_csv()
			_ 		-> IO.puts("Invalid answer")
					   start()
		end
		# ask user for filename
		# open file and read
		# parse the data
		# ask user for command
		# (read todos, add todos, delete todos, load file, save files)
	end

	def create_initial_todo do
		titles = create_headers()
		name = get_item_name(%{})
		fields = Enum.map(titles, &(field_from_user(&1)))
		IO.puts(~s(New todo "#{name}" added.))
		%{name => Enum.into(fields, %{})}
	end

	def create_headers do
		IO.puts("What data should each todo have?\n"
		<> "Enter field names one by one and an empty line when you're done.\n")
		create_header([])
	end

	def create_header(headers) do
		case IO.gets("Add field: ") |> String.trim do
			""		-> headers 
			header  -> create_header([header | headers])
		end
	end

	def read(filename) do
		case File.read(filename) do
			{:ok,body}  	-> body
			{:error,reason} -> IO.puts(~s(Could not open file "#{filename}".\n))
							   IO.puts(~s("#{:file.format_error reason}"\n))
							   start()
		end
	end

	def parse(body) do
		# headaer = Item, Priority, Urgency, Date Added, Notes
		[header|lines] = String.split(body, ~r<(\r\n|\r|\n)>)
		# parse headers without the item header
		titles = tl String.split(header,",")
		parse_lines(titles,lines)
	end

	def parse_lines(titles,lines) do
		# Enum.reduce(enumerable, starting value(optional), function(a,b)) invokes function for each elements in the enumerable with the accumulator
		# Enum.zip(enumerables) zips corresponding elements from finite collection of enumerables into a list of tuples
		# Enum.into(enumerable, collectable, transform) inserts the given enumerable into a collectable
		# Map.merge() merges two maps into one
		# a = current_line
		# b = map that has been built so far(accumulator)
		Enum.reduce(lines,%{}, fn a, b ->
			[name | fields] = String.split(a,",")
			# fields match amount of titles
			if(Enum.count(fields) == Enum.count(titles)) do
				line_data = Enum.zip(titles,fields) |> Enum.into(%{})
				Map.merge(b, %{name => line_data})
			else
				b
			end
		end)
	end

	# default is true if only one command is put in
	def show_todos(data, next_command? \\true) do
		# gives you just the keys of the map
		items = Map.keys(data)
		IO.puts("You have the following Todos:\n")
		Enum.each(items, fn item -> IO.puts(item) end)
		IO.puts("\n")
		if(next_command?) do
			get_command(data)
		end
	end

	def get_command(data) do
		prompt = """
Type the first letter of the command you want to run
	R)ead Todos 	
	A)dd a Todo 	
	D)elete a Todo 		
	L)oad a .csv 	
	S)ave a .csv
	Q)uit
"""
		command = IO.gets(prompt)
				|> String.trim
				|> String.downcase

		case command do
			"r"		-> show_todos(data)
			"a"		-> add_todo(data)
			"d"		-> delete_todo(data)
			"l"		-> load_csv()
			"s"		-> save_csv(data)
			"q"		-> "Goodbye!"
			_ 		-> IO.puts("Invalid Input. Please try again.")
						get_command(data)
		end
	end

	def add_todo(data) do
		# get name 
		# get titles (column headers)
		# get field values from user
		# create todo
		# merge into data
		name = get_item_name(data)
		titles = get_fields(data)
		# executes function on every single element
		fields = Enum.map(titles, fn field -> field_from_user(field) end)
		new_todo = %{name => Enum.into(fields,%{})}
		IO.puts(~s(New todo "#{name}" added.))
		new_data = Map.merge(data,new_todo)
		get_command(new_data)
		# get_command(new_data)
	end

	def delete_todo(data) do
		todo = IO.gets("Which todo would you like to delete?\n") 
			|> String.trim
		# Map.has_key?(map,key) returns whether the given keys exists in the given map
		if(Map.has_key?(data,todo)) do 
			IO.puts("Ok.")
			# drop(map, keys) drops the given keys from map.
			newMap = Map.drop(data, [todo])
			IO.puts(~s("#{todo}" has been deleted.))
			get_command(newMap)
		else 
			IO.puts(~s(There is no Todo named "#{todo}"))
			show_todos(data, false)
			delete_todo(data)
		end
	end

	def load_csv() do
		filename = IO.gets("Name of .csv to load: ") 
				|> String.trim()
		read(filename)
			|> parse()
			|> get_command()
	end

	def get_item_name(data) do
		name = IO.gets("Enter the name of the new todo: ")
			|> String.trim()
		if(Map.has_key?(data,name)) do
			IO.puts("Todo with that name already exists!\n")
			get_item_name(data)
		else 
			name
		end
	end

	def get_fields(data) do
		data[hd Map.keys data]
			|> Map.keys
	end

	def field_from_user(name) do
		field = IO.gets("#{name}: ")
			|> String.trim
		case field do
			_ 		-> {name, field}
		end
	end

	def prepare_csv(data) do
		headers = ["item" | get_fields(data)]
		items = Map.keys(data)
		item_rows =  Enum.map(items, fn item ->
			[item | Map.values(data[item])]
		end)
		rows = [headers | item_rows]
		row_strings = Enum.map(rows, &(Enum.join(&1, ",")))
		Enum.join(row_strings, "\n")
	end

	def save_csv(data) do
		filename = IO.gets("Name of .csv to save: ") |> String.trim
		filedata = prepare_csv(data)
		case File.write(filename, filedata) do
			:ok					-> IO.puts("Saved successfully.")
								   get_command(data)
			{:error, reason}	-> IO.puts(~s(Could not save file "#{filename}"))
								   IO.puts(~s("#{:file.format_error reason}"\n))
								   get_command(data)
		end
	end

end