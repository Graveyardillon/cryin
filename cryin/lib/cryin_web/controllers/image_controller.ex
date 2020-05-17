defmodule CryinWeb.ImageController do
  use CryinWeb, :controller

  import Mogrify

  alias Cryin.Drawer

  @path "./assets/static/images/"
  @debug_path "./assets/static/debug_images/"
  @source_path "./assets/static/image_sources/"

  @doc """
  Generate a diagram.
  """
  def generate_diagram(conn = %{method: "POST"}, %{"players_num" => num}) do
    # Create a banner from image_sources/banner.png
    open(@source_path <> "banner.png")
    |> IO.inspect
    |> resize("400x100")
    |> create(path: @path)
    
    banner_path = @path <> "banner.png"

    # Create a canvas
    %Mogrify.Image{path: "canvas.png", ext: "png"}
    |> custom("size", "1600x1200")
    |> canvas("#ECF0F3")
    |> image_operator("convert #{banner_path} -gravity northwest -geometry +100+50 -compose over -composite")
    |> create(path: @path)

    msg = "Created rect.png in: " <> @path
    json(conn, %{message: "ok", num: num})
  end
  def generate_diagram(conn, _params), do: json(conn, %{message: "Parameters are required."})

  # DEBUG ZONE
  def debug_soft_corner(conn = %{method: "POST"}, _params) do
    %Mogrify.Image{path: "debug_soft_corner.png", ext: "png"}
    |> custom("size", "400x300")
    |> canvas("#ECF0F3")
    |> image_operator("convert -alpha set -virtual-pixel transparent -channel A -blur 0x15 -threshold 50% +channel")
    |> create(path: @debug_path)

    msg = "[!DEBUG] Done"
    json(conn, %{message: msg})
  end
  def debug_generate(conn = %{method: "POST"}, _params) do
    %Mogrify.Image{path: "test.png", ext: "png"}
    |> custom("size", "280x280")
    |> canvas("#ECF0F3")
    |> custom("fill", "blue")
    |> Mogrify.Draw.circle(140,140,100,100)
    |> custom("fill", "yellow")
    |> Mogrify.Draw.circle(140,140,140,100)
    |> IO.inspect()
    |> create(path: @debug_path)

    msg = "Created test.png in: " <> @path
    json(conn, %{message: msg})
  end
end