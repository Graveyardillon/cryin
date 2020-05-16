defmodule CryinWeb.ImageController do
  use CryinWeb, :controller
  import Mogrify

  def generate(conn = %{method: "POST"}, _params) do
    %Mogrify.Image{path: "test.png", ext: "png"}
    |> custom("size", "280x280")
    |> canvas("white")
    |> custom("fill", "blue")
    |> Mogrify.Draw.circle(140,140,100,100)
    |> custom("fill", "yellow")
    |> Mogrify.Draw.circle(140,140,140,100)
    |> IO.inspect()
    |> create(path: ".")

    json(conn, %{message: "api worked!"})
  end
end