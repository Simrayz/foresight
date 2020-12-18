defmodule Foresight.Parser.Title do
  @moduledoc """
  A parser to get the title of a given html document
  """
  @title_tags ["meta[property='og:title']", "meta[name='twitter:title']", "meta[property='og:site_name']", "title"]

  def search_title(doc) when is_binary(doc) do
    doc
    |> Floki.parse_document!
    |> search_title()
  end

  def search_title(doc) do
    doc
    |> find_title(@title_tags)
  end

  defp find_title(doc, ["title" | tail]) do
    case Floki.find(doc, "title") do
      [] -> find_title(doc, tail)
      [ title | _ ] ->
        title
        |> Floki.text()
    end
  end

  defp find_title(doc, [tag | tail]) do
    case Floki.find(doc, tag) do
      [] -> find_title(doc, tail)
      [ title | _ ] ->
        title
        |> Floki.attribute("content")
        |> List.first()
    end
  end

  defp find_title(_doc, []) do
    nil
  end
end
