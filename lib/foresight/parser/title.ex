defmodule Foresight.Parser.Title do
  @moduledoc """
  A parser to get the title of a given html document
  """
  @title_tags ["meta[property='og:title']", "meta[name='twitter:title']", "title", "meta[property='og:site_name']"]

  def search_title(doc) when is_binary(doc) do
    doc
    |> Floki.parse_document!
    |> search_title()
  end

  def search_title(doc) do
    doc
    |> find_title(@title_tags)
  end

  defp find_title(doc, [tag | tail]) do
    case Floki.find(doc, tag) do
      [] -> find_title(doc, tail)
      [ title ] ->
        title
        |> Floki.attribute("content")
        |> List.first()
    end
  end
end
