defmodule Pollingtest do
	use Task

    def start_link() do
      Task.start_link(fn -> poll() end)
    end

    def poll() do
      Process.sleep(:timer.seconds(2))
      get_price()
      poll()
    end

    def get_price() do
      # Call API & Persist
      IO.puts "To the moon!"
    end
end