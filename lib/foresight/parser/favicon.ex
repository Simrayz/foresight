defmodule Foresight.Parser.Favicon do
  @moduledoc """
  A parser to get favicons from the given html document
  """
  alias Foresight.Page

  @favicon_tags ["link[rel='icon']", "link[rel='apple-touch-icon']", "link[rel='shortcut icon']"]

  def search_favicon(doc, %Page{url: _url} = page) when is_binary(doc) do
    doc
    |> Floki.parse_document!()
    |> search_favicon(page)
  end

  def search_favicon(doc, %Page{url: _url} = page) do
    doc
    |> find_favicon(@favicon_tags)
    |> get_relative_or_absolute_path(page)
  end

  defp find_favicon(doc, [tag | tail]) do
    case Floki.find(doc, tag) do
      [] ->
        find_favicon(doc, tail)

      [image | _] ->
        image
        |> Floki.attribute("href")
        |> List.first()
    end
  end

  defp find_favicon(_doc, []) do
    nil
  end

  defp get_relative_or_absolute_path(nil, %Page{}) do
    nil
  end

  defp get_relative_or_absolute_path(path, %Page{url: url}) do
    case URI.parse(path) do
      %URI{host: nil} ->
        %URI{host: host, scheme: scheme} = URI.parse(url)
        "#{scheme}://#{host}#{path}"

      _else ->
        path
    end
  end
end
