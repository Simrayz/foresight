defmodule Foresight.Parser.Image do
  @moduledoc """
  A parser to get the image of a given html document
  """
  @desc_tags ["meta[property='og:image']", "link[rel='image_src']", "meta[name='twitter:image']"]

  def search_image(doc) when is_binary(doc) do
    doc
    |> Floki.parse_document!()
    |> search_image()
  end

  def search_image(doc) do
    doc
    |> find_image(@desc_tags)
    |> sanitize_image()
  end

  defp find_image(doc, [tag | tail]) do
    case Floki.find(doc, tag) do
      [] ->
        find_image(doc, tail)

      [image | _] ->
        image
        |> Floki.attribute("content")
        |> List.first()
    end
  end

  defp find_image(_doc, []) do
    nil
  end

  defp sanitize_image(nil) do
    nil
  end

  defp sanitize_image(url) do
    %URI{scheme: scheme, host: host, path: path} = URI.parse(url)
    scheme <> "://" <> host <> path
  end
end
