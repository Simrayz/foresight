defmodule Foresight do
  @moduledoc """
  Documentation for `Foresight`.
  """

  alias Foresight.{HTML, Parser}

  @doc """
  Get a page struct if the URL is a real website.

  ## Examples
    iex> Foresight.get_page("https://google.com")
    {:ok,
      %Foresight.Page{
        description: "Hurra for Halloween 2020! #GoogleDoodle",
        image: "https://www.google.com/logos/doodles/2020/halloween-2020-6753651837108597.5-2xa.gif",
        title: "Google",
        url: "https://google.com"
      }
    }
  """
  def get_page(url, fields \\ [:title, :description, :image, :icon]) do
    case HTML.get_url(url) do
      {:ok, resp} ->
        {:ok, Parser.build_page(resp, fields)}

      {:error, _code} ->
        {:error, :not_found}
    end
  end

  @doc """
  Get a page struct if the URL is a real website, otherwise return error.

  ## Examples
    iex> Foresight.get_page("https://google.com")
    %Foresight.Page{
      description: "Hurra for Halloween 2020! #GoogleDoodle",
      image: "https://www.google.com/logos/doodles/2020/halloween-2020-6753651837108597.5-2xa.gif",
      title: "Google",
      url: "https://google.com"
    }
  """
  def get_page!(url) do
    HTML.get_url!(url)
    |> Parser.build_page()
  end

  def get_meta_tags!(url) do
    html = HTML.get_url!(url)
    Parser.get_meta_tags(html.body)
  end
end
