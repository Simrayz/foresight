defmodule Foresight.Parser.Description do
  @moduledoc """
  A parser to get the description of a given html document
  """
  @desc_tags ["meta[property='og:description']", "meta[name='description']"]

  def search_description(doc) when is_binary(doc) do
    doc
    |> Floki.parse_document!
    |> search_description()
  end

  def search_description(doc) do
    doc
    |> find_description(@desc_tags)
  end

  defp find_description(doc, [tag | tail]) do
    case Floki.find(doc, tag) do
      [] -> find_description(doc, tail)
      [ desc | _] ->
        desc
        |> Floki.attribute("content")
        |> List.first()
    end
  end

  defp find_description(_doc, []) do
    nil
  end
end
