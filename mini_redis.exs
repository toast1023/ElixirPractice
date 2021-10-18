defmodule MiniRedis do
	use GenServer
	# constructor, called when server is started
	# returns {:ok, state}
	def init(_) do
		{:ok, %{}}
	end

# _________________________________________________________________________________
# 	public interface
	def start_link(opts \\ [])do
		GenServer.start_link(__MODULE__,[],opts)
	end

	def set(key,value) do
		GenServer.call(__MODULE__,{:set,key,value})
	end

	def get(key) do
		GenServer.call(__MODULE__,{:get,key})
	end

# _________________________________________________________________________________
	# synchronous function, callback that is called when message arrives to server
	# returns {:reply, reponse, new_state}
	def handle_call({:set,key,value},_from, state) do
		# Map.merge(1,2) merges map 1 and map 2
		{:reply,:ok, Map.merge(state,%{key=> value})}
	end

	def handle_call({:get,key}, _from, state) do
		# Map.fetch(map,key) fetches the value for the specific key from the given map
		{:reply, Map.fetch(state,key),state}
	end
end