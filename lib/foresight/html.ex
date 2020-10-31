defmodule Foresight.HTML do
  @moduledoc """
  This module contains functions to fetch HTML documents.
  """

  @doc """
  Takes a URL and returns the HTML document if found.
  """
  def get_html(url) do
    url
    |> get_url!
    |> get_body
  end

  @doc """
  Takes a URL, and returns a `{:ok, %HTTPoison.Response{}}` tuple, or `{:error, reason}` if something goes wrong.
  It follows redirects to a maximum of 5 in total. This is necessary on e.g. `https://google.com`
  """
  def get_url(url) do
    HTTPoison.get(url, [], follow_redirect: true, max_redirect: 5)
    |> parse_response()
  end

  @doc """
  Bang! version of get_url
  Takes a URL, and returns a %HTTPoison.Response{} or throws an error.
  It follows redirects to a maximum of 5 in total. This is necessary on e.g. `https://google.com`
  """
  def get_url!(url) do
    HTTPoison.get!(url, [], follow_redirect: true, max_redirect: 5)
  end

  @doc """
  Takes a `%HTTPoison.Response{}` and returns the `body`, otherwise `nil`
  """
  def get_body(%HTTPoison.Response{body: body}) do
    body
  end

  def get_body(_else) do
    ""
  end

  defp parse_response(resp) do
    case resp do
      {:ok, %HTTPoison.Response{status_code: 200} = resp} ->
        {:ok, resp}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found}
      {:ok, %HTTPoison.Response{status_code: code}} ->
        {:error, code}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
