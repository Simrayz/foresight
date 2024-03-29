defmodule Foresight.Parser do
  @moduledoc """
  A parser to get meta information
  """
  alias Foresight.Parser.{Default, Title, Image, Favicon}
  alias Foresight.Page

  def build_page(%HTTPoison.Response{body: body} = resp, fields \\ []) do
    head_doc =
      body
      |> Floki.parse_document!()
      |> Floki.find("head")

    %Page{url: resp.request.url}
    |> parse_document(fields, head_doc)
  end

  @doc """
  Parse the given fields from a document, and put the results on the %Page{}
  """
  def parse_document(%Page{} = page, [field | fields], document) do
    page
    |> parse_field(field, document)
    |> parse_document(fields, document)
  end

  def parse_document(%Page{} = page, [], _document) do
    page
  end

  defp parse_field(%Page{} = page, :title, document) do
    Map.put(page, :title, Title.search_title(document))
  end

  defp parse_field(%Page{} = page, :description, document) do
    Map.put(page, :description, Default.search_field(document, :description))
  end

  defp parse_field(%Page{} = page, :type, document) do
    Map.put(page, :type, Default.search_field(document, :type))
  end

  defp parse_field(%Page{} = page, :site_name, document) do
    Map.put(page, :site_name, Default.search_field(document, :site_name))
  end

  defp parse_field(%Page{} = page, :image, document) do
    Map.put(page, :image, Image.search_image(document, page))
  end

  defp parse_field(%Page{} = page, :icon, document) do
    Map.put(page, :icon, Favicon.search_favicon(document, page))
  end

  defp parse_field(%Page{} = page, _field, _document) do
    page
  end

  @doc "A context function to get all <meta> tags from the raw html body"
  def get_meta_tags(doc) do
    doc
    |> Floki.parse_document!()
    |> Floki.find("meta")
  end
end
