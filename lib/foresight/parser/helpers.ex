defmodule Foresight.Parser.Helpers do
  @moduledoc """
  A helper module for parsing urls and returning proper types
  """

  def find_tag(document, tags, attribute \\ "content")

  def find_tag(doc, [tag | tail], attribute) do
    case Floki.find(doc, tag) do
      [] ->
        find_tag(doc, tail, attribute)

      [tag | _] ->
        tag
        |> Floki.attribute(attribute)
        |> List.first()
    end
  end

  def find_tag(_doc, [], _attribute) do
    nil
  end

  def parse_image_path(nil, _page) do
    nil
  end

  def parse_image_path(path, %Foresight.Page{url: url}) do
    %URI{scheme: page_scheme, host: page_host} = URI.parse(url)

    case URI.parse(path) do
      %URI{scheme: "https"} ->
        path

      %URI{scheme: "http"} ->
        path

      %URI{host: nil, path: "/" <> file} ->
        "#{page_scheme}://#{page_host}/#{file}"

      %URI{host: nil} ->
        nil
    end
  end
end
