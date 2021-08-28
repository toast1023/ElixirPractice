defmodule ShoppingList do
	use GenServer


	# Client
	# returns {:ok, pid}
	def start_link() do
		# __MODULE__ returns shopping list module
		GenServer.start_link(__MODULE__, [])
	end

	def add(pid,item) do
		# asynchronous, does not care about response
		# handle_cast is invoked
		GenServer.cast(pid, item)
	end

	def view(pid) do
		# synchronous, cares about response
		# invokes handle_call
		GenServer.call(pid, :view)
	end

	def remove(pid, item) do
		GenServer.cast(pid, {:remove, item})
	end

	def stop(pid) do
		# callback = terminate
		GenServer.stop(pid, :normal, :infinity)
	end

	# Server
	# start_link triggers init(initialstate) callback
	def init(list) do
		{:ok, list}
	end

	def handle_cast({:remove, item}, list) do
		updated_list = Enum.reject(list, fn(x) -> x == item end)
		{:noreply, updated_list}
	end

	def handle_cast(item, list) do
		updated_list = [item | list]
		# expects 2 element tuple as return
		{:noreply, updated_list}
	end

	def handle_call(:view, _from, list) do
		# :reply, what we want to return, state that you want to continue in
		{:reply, list, list}
	end

	def terminuate(_reason, list) do
		IO.puts("Done shopping!")
		IO.inspect(list)
		:ok
	end
end