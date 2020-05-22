defmodule CryinWeb.ImageController do
  use CryinWeb, :controller

  import Mogrify

  alias Cryin.Drawer

  def generate(conn = %{method: "POST"}, _params) do
    path = "./assets/static/images/"

    %Mogrify.Image{path: "test.png", ext: "png"}
    |> custom("size", "280x280")
    |> canvas("white")
    |> custom("fill", "blue")
    |> Mogrify.Draw.circle(140,140,100,100)
    |> custom("fill", "yellow")
    |> Mogrify.Draw.circle(140,140,140,100)
    |> IO.inspect()
    |> create(path: path)

    msg = "Created test.png in: " <> path
    json(conn, %{message: msg})
  end

  def generate_rects(conn = %{method: "POST"}, %{"player_num" => num}) do
    path = "./assets/static/images/"

    %Mogrify.Image{path: "rect.png", ext: "png"}
    |> custom("size", "1600x1200")
    |> canvas("white")
    |> Drawer.draw_rects(num)
    |> create(path: path)

    msg = "Created rect.png in: " <> path
    json(conn, %{message: msg, num: num})
  end
end