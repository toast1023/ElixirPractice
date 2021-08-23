defmodule CryptoSearch do
  def start do
    get_command()
  end

  def get_ticker() do
    ticker = IO.gets("Please enter coin ticker: \n")
      |> String.trim() 
      |> String.downcase()
  end

  def get_command() do
    prompt = """
Type the first letter of the command you want to run
  S)earch for crypto   
  I)nformation about program 
  Q)uit
"""
    command = IO.gets(prompt)
        |> String.trim
        |> String.downcase

    case command do
      "s"   -> get_ticker()
                |> fetch_data()
                get_command()
      "i"   -> IO.puts("\n\n\tThis project was created by William Chen using Elixir and the Messari API.\n\n")
                get_command()
      "q"   -> IO.puts("\n\n\tGoodbye!\n\n")
      _     -> IO.puts("Invalid Input. Please try again.\n")
            get_command()
    end
  end

  def fetch_data(ticker) do
    %{body: body} = HTTPoison.get!(data_url(ticker))
    coin = Poison.decode!(body, keys: :atoms)
    IO.puts("\n\tName: #{coin.data.name}")
    IO.puts("\tSymbol: #{coin.data.symbol}\n")
    IO.puts("\tMarket data:")
    IO.puts("\t   Price USD: #{coin.data.market_data.price_usd}")
    IO.puts("\t   Price BTC: #{coin.data.market_data.price_btc}")
    IO.puts("\t   Change last hour: #{coin.data.market_data.percent_change_usd_last_1_hour}")
    IO.puts("\t   Change 24 hours: #{coin.data.market_data.percent_change_usd_last_24_hours}")
    IO.puts("\t   Volume last 24 hours: #{coin.data.market_data.volume_last_24_hours}")
    IO.puts("\t   Open: #{coin.data.market_data.ohlcv_last_24_hour.open}")
    IO.puts("\t   High: #{coin.data.market_data.ohlcv_last_1_hour.high}")
    IO.puts("\t   Low: #{coin.data.market_data.ohlcv_last_1_hour.low}")
    IO.puts("\t   Close: #{coin.data.market_data.ohlcv_last_1_hour.close}\n")

    IO.puts("\tMarket cap:")
    IO.puts("\t   Current rank: #{coin.data.marketcap.rank}")
    IO.puts("\t   Market percentage: #{coin.data.marketcap.marketcap_dominance_percent}%\n")

    IO.puts("\tSupply:")
    IO.puts("\t   Circulating: #{coin.data.supply.circulating}")
    IO.puts("\t   Annual inflation: #{coin.data.supply.annual_inflation_percent}\n")

    IO.puts("\tAll time high: #{coin.data.all_time_high.price} on #{coin.data.all_time_high.at}\n")

    # coin.data.market_data
  end

  def data_url(ticker) do
    # IO.puts(ticker)
    # https://data.messari.io/api/v1/assets/eth/metrics
    data_api = "https://data.messari.io/api/v1/assets/"
    # IO.puts("#{data_api}#{ticker}/metrics")
    coin = "#{data_api}#{ticker}/metrics"
  end
end
