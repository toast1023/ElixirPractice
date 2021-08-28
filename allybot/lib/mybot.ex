defmodule MyBot do
  use Application
  alias Alchemy.Client


  defmodule Commands do
    use Alchemy.Cogs

    Cogs.def boop do
      Cogs.say "Boop!"
    end

    Cogs.def bernard do
      Cogs.say ("```fix\nHey stud\n\t\twhat you wearing tn uwu```")
    end

    Cogs.def kanye do
      quote = fetch_quotes()
      Cogs.say quote
    end

    Cogs.def currency(ticker) do
      info = fetch_data(ticker)
      Cogs.say info
    end

    Cogs.def currency() do
      Cogs.say ~s(Please specify ticker in second argument.\n
        Example: "!currency btc")
    end

    Cogs.def convert(string) do
      [num, ticker] = String.split(string,",")
      num = num |> Float.parse() |> elem(0)
      ticker = ticker |> String.upcase()
      price = fetch_price(ticker)
      usd_price = (price * num) |> Decimal.from_float() |> Decimal.round(3)
      output = ("#{num} #{ticker} is #{usd_price} USD")
      Cogs.say output
    end

    Cogs.def convert() do
      Cogs.say ~s(Please specify number in second argument, ticker in third argument, seperated by a comma no spaces.\n
        Example: "!convert 10,btc")
    end

    Cogs.def alert(string) do
      [num, ticker] = String.split(string,",")
      num = num |> Float.parse() |> elem(0)
      ticker = ticker |> String.upcase()
      price = fetch_price(ticker)
      if (num < price) do
        Cogs.say "Coin has already surpassed price!"
      else
        Cogs.say "Notification for #{ticker} at price $#{num} created."
        ping_api(ticker,num)
        Cogs.say "#{ticker} has surpassed $#{num}! To the moon!"
        # output = ping_api(ticker,num)
        # Cogs.say output
      end
    end

    def fetch_price(ticker) do
      %{body: body} = HTTPoison.get!(data_url(ticker))
      coin = Poison.decode!(body, keys: :atoms)
      myString = ("#{coin.data.market_data.price_usd}")
                |> Float.parse()
                |> elem(0)
    end

    def fetch_data(ticker) do
      %{body: body} = HTTPoison.get!(data_url(ticker))
      coin = Poison.decode!(body, keys: :atoms)
      price = ("#{coin.data.market_data.price_usd}") |> Float.parse() |> elem(0) |> Decimal.from_float() |> Decimal.round(3)
      priceBTC = ("#{coin.data.market_data.price_btc}") |> Float.parse() |> elem(0) |> Decimal.from_float() |> Decimal.round(5)
      changeHour = ("#{coin.data.market_data.percent_change_usd_last_1_hour}") |> Float.parse() |> elem(0) |> Decimal.from_float() |> Decimal.round(5)
      change24 = ("#{coin.data.market_data.percent_change_usd_last_24_hours}") |> Float.parse() |> elem(0) |> Decimal.from_float() |> Decimal.round(5)
      volume24 = ("#{coin.data.market_data.volume_last_24_hours}") |> Float.parse() |> elem(0) |> Decimal.from_float() |> Decimal.round(5)
      marketPercentage = ("#{coin.data.marketcap.marketcap_dominance_percent}") |> Float.parse() |> elem(0) |> Decimal.from_float() |> Decimal.round(3)
      open = ("#{coin.data.market_data.ohlcv_last_24_hour.open}") |> Float.parse() |> elem(0) |> Decimal.from_float() |> Decimal.round(5)
      high = ("#{coin.data.market_data.ohlcv_last_1_hour.high}") |> Float.parse() |> elem(0) |> Decimal.from_float() |> Decimal.round(5)
      low = ("#{coin.data.market_data.ohlcv_last_1_hour.low}") |> Float.parse() |> elem(0) |> Decimal.from_float() |> Decimal.round(5)
      close = ("#{coin.data.market_data.ohlcv_last_1_hour.close}") |> Float.parse() |> elem(0) |> Decimal.from_float() |> Decimal.round(5)
      myString = ("```elixir\n~#{coin.data.name}~\n")
      <> ("Symbol: #{coin.data.symbol}\n\n")
      <> ("Market data:\n")
      <> ("   Price USD: #{price}\n")
      <> ("   Price BTC: #{priceBTC}\n")
      <> ("   Change last hour: #{changeHour}\n")
      <> ("   Change 24 hours: #{change24}\n")
      <> ("   Volume 24 hours: #{volume24}\n")
      <> ("   Open: #{open}\n")
      <> ("   High: #{high}\n")
      <> ("   Low: #{low}\n")
      <> ("   Close: #{close}\n\n")

      <> ("Market cap:\n")
      <> ("   Current rank: #{coin.data.marketcap.rank}\n")
      <> ("   Market percentage: #{marketPercentage}%\n\n")

      <> ("Supply:\n")
      <> ("   Circulating: #{coin.data.supply.circulating}\n")
      <> ("   Annual inflation: #{coin.data.supply.annual_inflation_percent}\n\n")

      <> ("All time high: #{coin.data.all_time_high.price} on #{coin.data.all_time_high.at}\n\n```")

      # coin.data.market_data
    end

    def fetch_quotes do
      %{body: body} = HTTPoison.get!(quote_url)
      quote = Poison.decode!(body, keys: :atoms)
      quote.quote
    end

    def quote_url do
      kanye_url = "api.kanye.rest"
    end

    def data_url(ticker) do
      # IO.puts(ticker)
      # https://data.messari.io/api/v1/assets/eth/metrics
      data_api = "https://data.messari.io/api/v1/assets/"
      # IO.puts("#{data_api}#{ticker}/metrics")
      coin = "#{data_api}#{ticker}/metrics"
    end

  # # _________TASK POLLING__________________________________________________________

    use Task
    def ping_api(ticker,num) do
      myTask = Task.async(fn -> poll(ticker,num) end)
      returnMe = Task.await(myTask, :infinity)
    end

    def poll(ticker,num) do
      real_time_price = get_price(ticker,num)
      if (real_time_price > num) do
        real_time_price
      else
        Process.sleep(:timer.seconds(10))
        IO.puts("#{ticker}: #{real_time_price}")
        poll(ticker,num)
      end
    end

    def get_price(ticker,num) do
      # Call API & Persist
      # IO.puts "#{ticker} #{num}"
      hello = fetch_price(ticker)
    end
    
  

  # # ________________________________________________________________________________
  #   use GenServer
  #   # Client
  #   # returns {:ok, pid}
  #   def start_link() do
  #     # __MODULE__ returns shopping list module
  #     GenServer.start_link(__MODULE__, [])
  #   end

  #   def add(pid,item) do
  #     # asynchronous, does not care about response
  #     # handle_cast is invoked
  #     GenServer.cast(pid, item)
  #   end

  #   def view(pid) do
  #     # synchronous, cares about response
  #     # invokes handle_call
  #     GenServer.call(pid, :view)
  #   end

  #   def remove(pid, item) do
  #     GenServer.cast(pid, {:remove, item})
  #   end

  #   def stop(pid) do
  #     # callback = terminate
  #     GenServer.stop(pid, :normal, :infinity)
  #   end

  #   # Server
  #   # start_link triggers init(initialstate) callback
  #   def init(list) do
  #     {:ok, list}
  #   end

  #   def handle_cast({:remove, item}, list) do
  #     updated_list = Enum.reject(list, fn(x) -> x == item end)
  #     {:noreply, updated_list}
  #   end

  #   def handle_cast(item, list) do
  #     updated_list = [item | list]
  #     # expects 2 element tuple as return
  #     {:noreply, updated_list}
  #   end

  #   def handle_call(:view, _from, list) do
  #     # :reply, what we want to return, state that you want to continue in
  #     {:reply, list, list}
  #   end

  #   def terminuate(_reason, list) do
  #     IO.puts("Done shopping!")
  #     IO.inspect(list)
  #     :ok
  #   end


  # # ________________________________________________________________________________
  end

  def start(_type, _args) do
    run = Client.start("ODc5OTg0ODcwNzAzNjU2OTYw.YSXrxg.y9Z2lSJWm2o-6KjZkTqx6_EJZmM")
    use Commands
    run
  end
  
end

