defmodule Cryin.Drawer do
  import Mogrify

  @width 400
  @height 100
  @banner_image_path "./assets/static/images/soft_corner.png"

  def draw_rects(image, num) do
    draw_player_rects(image, num)
  end

  defp draw_player_rects(image, num, count \\ 0) do
    if num == count do
      image
    else
      # Set offset of each rectangle
      difw = 120
      difh = 120
      offw = difw
      offh = (@height + 30) * count + difh

      image
      |> image_operator("convert -size: 25x100 #{@banner_image_path} \ ")
      |> draw_player_rects(num, count+1)
    end
  end
end