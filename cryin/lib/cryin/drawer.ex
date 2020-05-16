defmodule Cryin.Drawer do
  import Mogrify

  def draw_rect(image) do
    image
    |> custom("fill", "black")
    |> Mogrify.Draw.rectangle(50, 50, 200, 100)
  end
end