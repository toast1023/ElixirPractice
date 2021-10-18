defmodule MyBot do
  use Application
  alias Alchemy.Client


  defmodule Commands do
    use Alchemy.Cogs

    Cogs.def boop do
      Cogs.say "Boop!"
    end

    Cogs.def bernard do
      num = :rand.uniform(6)
      case num do
        1 -> Cogs.say ("```fix\nHey stud\n\t\twhat you wearing tn uwu```")
        2 -> Cogs.say("```fix\nmY keYbOarD```")
        3 -> Cogs.say("```fix\ni luv nEw wOrLd uwu```")
        4 -> Cogs.say("```fix\ndummy thicc```")
        5 -> Cogs.say("```fix\ni wiLL beComE tHe hOkAgE dAttEbAyO```")
        6 -> Cogs.say("```fix\nmy name is Benny```")
      end
    end

    Cogs.def kanye do
      quote = Fetch.kanye_quotes()
      Cogs.say quote
    end

    Cogs.def currency(ticker) do
      info = Fetch.data(ticker)
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
      price = Fetch.price(ticker)
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
      price = Fetch.price(ticker)
      if (num < price) do
        Cogs.say "Coin has already surpassed price!"
      else
        {:ok, _} = BotServer.start_link{ticker, num}
        Cogs.say "Notification for #{ticker} at price $#{num} created."
        # Cogs.say "#{ticker} has surpassed $#{num}! To the moon!"
        # output = ping_api(ticker,num)
        # Cogs.say output
      end
    end

  # # _________TASK POLLING__________________________________________________________

  #   use Task
  #   def ping_api(ticker,num) do
  #     myTask = Task.async(fn -> poll(ticker,num) end)
  #     returnMe = Task.await(myTask, :infinity)
  #   end

  #   def poll(ticker,num) do
  #     real_time_price = get_price(ticker,num)
  #     if (real_time_price > num) do
  #       real_time_price
  #     else
  #       Process.sleep(:timer.seconds(10))
  #       IO.puts("#{ticker}: #{real_time_price}")
  #       poll(ticker,num)
  #     end
  #   end

  #   def get_price(ticker,num) do
  #     # Call API & Persist
  #     # IO.puts "#{ticker} #{num}"
  #     hello = Fetch.data(ticker)
  #   end
  end

  # # _______________________________________________________________________________
  def start(_type, _args) do
    run = Client.start("ODc5OTg0ODcwNzAzNjU2OTYw.YSXrxg.TmpzqnrKhqSeN9IxoNfDEfYjLCs")
    use Commands
    run
  end
  
end

