defmodule Foresight.Parser do
  @moduledoc """
  A parser to get meta information
  """

  def get_title(doc) do
    doc
    |> Floki.parse_document!
    |> Floki.find("title")
    |> List.first()
    |> Floki.text()
  end

  def get_meta_tags(doc) do
    doc
    |> Floki.parse_document!
    |> Floki.find("meta")
  end
end
