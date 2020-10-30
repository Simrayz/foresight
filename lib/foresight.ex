defmodule Foresight do
  @moduledoc """
  Documentation for `Foresight`.
  """

  alias Foresight.{HTML, Parser, Page}

  @doc """
  Hello world.

  ## Examples

      iex> Foresight.hello()
      :world

  """
  def hello do
    :world
  end

  def get_page(url) do
    case HTML.get_url(url) do
      {:ok, resp} ->
        title =
          resp.body
          |> Parser.get_title()

        {:ok, %Page{title: title, url: resp.request.url}}
      {:error, _code} ->
        {:error, :not_found}
    end
  end

  def get_page!(url) do
    resp = HTML.get_url!(url)
    title =
      resp
      |> Map.fetch!(:body)
      |> Parser.get_title
    %Page{title: title, url: resp.request.url}
  end
end
