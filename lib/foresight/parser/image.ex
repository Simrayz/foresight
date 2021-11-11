defmodule Foresight.Parser.Image do
  @moduledoc """
  A parser to get the image of a given html document
  """
  import Foresight.Parser.Helpers

  @image_tags ["meta[property='og:image']", "meta[name='twitter:image']", "link[rel='image_src']"]

  def search_image(doc, %Foresight.Page{url: _url} = page) when is_binary(doc) do
    doc
    |> Floki.parse_document!()
    |> search_image(page)
  end

  def search_image(doc, %Foresight.Page{url: _url} = page) do
    doc
    |> find_tag(@image_tags)
    |> parse_image_path(page)
  end
end
