defmodule ThisIsTheNewShitWeb.PageController do
  use ThisIsTheNewShitWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
