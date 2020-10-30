defmodule Foresight.Parser do
  @moduledoc """
  A parser to get meta information
  """
  alias Foresight.Parser.{Title}

  def get_title(doc) do
    Title.search_title(doc)
  end

  def get_meta_tags(doc) do
    doc
    |> Floki.parse_document!
    |> Floki.find("meta")
  end
end
