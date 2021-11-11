defmodule Foresight.Parser.Favicon do
  @moduledoc """
  A parser to get favicons from the given html document
  """
  import Foresight.Parser.Helpers
  alias Foresight.Page

  @favicon_tags ["link[rel='icon']", "link[rel='apple-touch-icon']", "link[rel='shortcut icon']"]

  def search_favicon(doc, %Page{url: _url} = page) when is_binary(doc) do
    doc
    |> Floki.parse_document!()
    |> search_favicon(page)
  end

  def search_favicon(doc, %Page{url: _url} = page) do
    doc
    |> find_tag(@favicon_tags, "href")
    |> parse_image_path(page)
  end
end
