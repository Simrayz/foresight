defmodule ForesightWeb.PreviewController do
  use ForesightWeb, :controller

  def info(conn, _) do
    vsn = Application.spec(:foresight, :vsn) |> to_string()

    json(conn, %{
      vsn: vsn,
      message: """
      Expects a `post` request with parameter {"url": "<valid_url>"}
      """
    })
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"url" => url}) do
    preview = Foresight.get_page!(url)
    json(conn, Map.from_struct(preview))
  end
end
