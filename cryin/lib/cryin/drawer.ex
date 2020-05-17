defmodule Cryin.Drawer do
  import Mogrify

  @width 400
  @height 100
  @offx 80
  @offy 200
  @distance 60
  @line_length 80
  @east_space 300

  def create_canvas(image, num) do
    canvas_width  = @offx + @width + @line_length*4 + @east_space
    canvas_height = @offy*2 + @height*num + @distance*(num-1)

    image
    |> custom("size", "#{canvas_width}x#{canvas_height}")
    |> canvas("#ECF0F3")
  end

  def merge_banners(image, banner_path, num) do
    image
    |> merge_banner(banner_path, num)
  end

  defp merge_banner(image, banner_path, num, count \\ 0) do
    if num == count do
      image
    else
      x = @offx
      y = @offy + @height*count + @distance*count

      image
      |> image_operator("convert #{banner_path} -gravity northwest -geometry +#{x}+#{y} -compose over -composite")
      |> merge_banner(banner_path, num, count+1)
    end
  end
end