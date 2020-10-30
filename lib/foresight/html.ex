defmodule Foresight.HTML do
  @moduledoc false

  def get_url(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200} = resp} ->
        {:ok, resp}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def get_body(%HTTPoison.Response{body: body}) do
    body
  end

  def get_body(_else) do
    ""
  end

  def get_meta_url(url) do
    IO.puts url
  end
end
