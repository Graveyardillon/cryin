defmodule CryinWeb.PageController do
  use CryinWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
