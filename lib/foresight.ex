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
        {:ok, build_page(resp)}
      {:error, _code} ->
        {:error, :not_found}
    end
  end

  def get_page!(url) do
    HTML.get_url!(url)
    |> build_page()
  end

  defp build_page(%HTTPoison.Response{body: body} = resp) do
    parsed_doc =
      body
      |> Floki.parse_document!

    title = Parser.get_title(parsed_doc)
    description = Parser.get_description(parsed_doc)
    image = Parser.get_image(parsed_doc)

    %Page{
      title: title,
      description: description,
      image: image,
      url: resp.request.url
    }
  end
end
