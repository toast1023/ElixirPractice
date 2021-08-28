defmodule Calculator do
  def start do
    spawn(fn -> loop(0) end)
  end

# client side
def view(server_pid) do
  send(server_pid,{:view,self()})

  receive do
    {:response, value} ->
      value
  end
end

def add(server_pid,value) do
  send(server_pid, {:add,value})
end

def sub(server_pid,value) do
  send(server_pid, {:sub,value})
end

def mult(server_pid,value) do
  send(server_pid, {:mult,value})
end

def div(server_pid,value) do
  send(server_pid, {:div,value})
end

# server sid
  def loop(current_value) do
    new_value = receive do
      {:view, caller_pid} -> 
        send(caller_pid, {:response,current_value})
        current_value

      {:add, value} -> 
        current_value + value

      {:sub, value} -> 
        current_value - value

      {:mult, value} -> 
        current_value * value

      {:div, value} -> 
        current_value / value

      _ -> IO.puts("Invalid")

    end

    loop(new_value)

  end
end
