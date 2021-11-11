defmodule Foresight.Parser.Default do
  @moduledoc """
  A parser to get the given field from a Floki document.

  The Default parser current supports the following fields:
  `:description`, `:site_name` and `:type`.
  """
  import Foresight.Parser.Helpers

  @tags_map %{
    description: [
      "meta[property='og:description']",
      "meta[property='twitter:description']",
      "meta[name='description']"
    ],
    site_name: [
      "meta[property='og:site_name']",
      "meta[property='twitter:site']"
    ],
    type: [
      "meta[property='og:type']"
    ]
  }

  def search_field(document, field) do
    search_tags(document, @tags_map[field])
  end

  defp search_tags(_document, nil) do
    nil
  end

  defp search_tags(doc, tags) when is_binary(doc) do
    doc
    |> Floki.parse_document!()
    |> search_tags(tags)
  end

  defp search_tags(doc, tags) do
    doc
    |> find_tag(tags)
  end
end
