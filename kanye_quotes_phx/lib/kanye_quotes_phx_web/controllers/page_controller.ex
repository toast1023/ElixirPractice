defmodule KanyeQuotesPhxWeb.PageController do
  use KanyeQuotesPhxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
