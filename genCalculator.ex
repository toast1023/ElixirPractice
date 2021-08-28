defmodule GenericServer do
	def start(module) do
		spawn(fn ->
			init_state = module.init()
			loop(module, init_state)
		end)
	end

	# defp is a private function
	defp loop(module, current_state) do
		receive do
			{request, caller} ->
				{response, new_state} = 
					module.handle_call(
						request, current_state
					)
				send(caller, {:response, response})
				loop(module, new_state)
		end
	end
	
	def call(server_pid, request) do
		send(server_pid,{request,self()})

		receive do
			{:response, response} ->
				response
		end
	end

	
end