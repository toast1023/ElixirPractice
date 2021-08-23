defmodule KanyeQuotes do
  def start do
    fetch_quotes()
  end

  def fetch_quotes do
    %{body: body} = HTTPoison.get!(quote_url)
    quote = Poison.decode!(body, keys: :atoms)
    quote.quote

  end

  def quote_url do
    kanye_url = "api.kanye.rest"
  end
end
