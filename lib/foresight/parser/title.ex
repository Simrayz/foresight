defmodule Foresight.Parser.Title do
  @moduledoc """
  A parser to get the title of a given html document
  """
  @title_tags ["meta[property='og:title']", "title"]

  def search_title(doc) when is_binary(doc) do
    doc
    |> Floki.parse_document!
    |> search_title()
  end

  def search_title(doc) do
    doc
    |> find_title(@title_tags)
    |> extract_title()
  end

  defp find_title(doc, [tag | tail]) do
    case Floki.find(doc, tag) do
      [] -> find_title(doc, tail)
      [ title ] -> title
    end
  end

  defp find_title(_doc, []) do
    nil
  end

  defp extract_title(nil) do
    nil
  end

  defp extract_title(node) do
    Floki.text(node)
  end
end
