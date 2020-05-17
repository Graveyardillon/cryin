defmodule Cryin.Drawer do
  import Mogrify

  @width 400
  @height 100

  def create_canvas(image) do
    image
    |> custom("size", "1600x1200")
    |> canvas("#ECF0F3")
  end

  def merge_banner(image, banner_path) do
    image
    |> image_operator("convert #{banner_path} -gravity northwest -geometry +100+50 -compose over -composite")
  end
end