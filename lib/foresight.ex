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
  def get_page(url, fields \\ default_fields()) do
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
  def get_page!(url, fields \\ default_fields()) do
    HTML.get_url!(url)
    |> Parser.build_page(fields)
  end

  def get_meta_tags!(url) do
    HTML.get_url!(url)
    |> Map.get(:body)
    |> Parser.get_meta_tags()
  end

  defp default_fields do
    Application.get_env(:foresight, :parse_fields, [
      :title,
      :description,
      :image,
      :icon,
      :type,
      :site_name
    ])
  end
end
