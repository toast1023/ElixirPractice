defmodule Mixtest do
  def test(markdown) do
    Earmark.as_html!((markdown || ""),%Earmark.Options{smartypants: false})
  end
end
