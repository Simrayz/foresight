defmodule Foresight.Parser do
  @moduledoc """
  A parser to get meta information
  """
  alias Foresight.Parser.{Title, Description, Image}

  @doc "A context function to abstract the underlying parser implementation of titles"
  def get_title(doc) do
    Title.search_title(doc)
  end

  @doc "A context function to abstract the underlying parser implementation of descriptions"
  def get_description(doc) do
    Description.search_description(doc)
  end

  @doc "A context function to abstract the underlying parser implementation of image url fetching"
  def get_image(doc) do
    Image.search_image(doc)
  end

  @doc "A context function to get all <meta> tags from the raw html body"
  def get_meta_tags(doc) do
    doc
    |> Floki.parse_document!
    |> Floki.find("meta")
  end
end
