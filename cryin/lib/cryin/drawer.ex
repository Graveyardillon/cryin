defmodule Cryin.Drawer do
  import Mogrify

  @width 400
  @height 100

  def draw_rects(image, num) do
    get_rect_list(image, num)
  end

  defp get_rect_list(image, num, count \\ 0) do
    if num == count do
      image
    else
      offw = 120
      offh = 120
      difw = offw
      difh = (@height + 30) * count + offh

      image
      |> custom("fill", "black")
      |> Mogrify.Draw.rectangle(difw, difh, difw+@width, difh+@height)
      |> get_rect_list(num, count+1)
    end
  end


end