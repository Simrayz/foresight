defmodule Foresight.HTML do
  @moduledoc false

  def get_url(url) do
    HTTPoison.get(url, [], follow_redirect: true, max_redirect: 5)
    |> parse_response()
  end

  def get_url!(url) do
    HTTPoison.get!(url, [], follow_redirect: true, max_redirect: 5)
  end

  def get_body(%HTTPoison.Response{body: body}) do
    body
  end

  def get_body(_else) do
    ""
  end

  def get_html(url) do
    url
    |> get_url!
    |> get_body
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
