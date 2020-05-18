defmodule Cryin.Drawer do
  import Mogrify

  alias Cryin.Utils

  @width 400
  @height 100
  @offx 80
  @offy 200
  @distance 60
  @line_length 80
  @line_width 5
  @east_space 300

  @doc """
  create_canvas/2
  Creates new canvas.
  The canvas extends its width and length
  depending on number of banners dynamically.
  """
  def create_canvas(image, num) do
    mul = Utils.block_index(num)
    canvas_width  = @offx + @width + @line_length*mul + @east_space
    canvas_height = @offy*2 + @height*num + @distance*(num-1)

    image
    |> custom("size", "#{canvas_width}x#{canvas_height}")
    |> canvas("#ECF0F3")
  end

  @doc """
  merge_banners/3
  Pastes banner on a canvas image.
  """
  def merge_banners(image, banner_path, num) do
    image
    |> merge_banner(banner_path, num)
  end

  defp merge_banner(image, banner_path, num, count \\ 0) do
    if num == count do
      IO.inspect("merge_banner_ended")
      image
    else
      IO.inspect("merge_banner")
      x = @offx
      y = @offy + @height*count + @distance*count

      image
      |> image_operator("convert #{banner_path} -gravity northwest -geometry +#{x}+#{y} -compose over -composite")
      |> merge_banner(banner_path, num, count+1)
    end
  end

  @doc """
  plot_lines/2
  Plots line which connects each banner.
  The data flow is like:
  image
  |> plot_lines/2
  |> get_center_coords/5
  |> plot/4 (Recurrent)
  |> go_or_match (It plots actually)
  """
  def plot_lines(image, num) do
    image
    |> get_center_coords(num)
  end

  # make a list of coordinates
  defp get_center_coords(image, num, index_h \\ 1, index_v \\ 1, coords \\ []) do
    if num+1 == index_v do
      plot(image, num, index_h, index_v, coords)
    end

    y = @offy + trunc(index_v/2)*@height + trunc((index_v-1)/2)*@distance
    coords = [y | coords]

    image
    |> get_center_coords(num, index_h, index_v+1, coords)
  end

  defp plot(image, num, index_h, index_v, coords, next_coords \\ []) do
    IO.inspect(coords)
    cond do
      length(coords) == 1 -> go(image, num, index_h, index_v, coords, next_coords)
      length(coords) == 0 -> proceed(image, num, index_h, index_v, next_coords)
      true -> match(image, num, index_h, index_v, coords, next_coords)
    end
  end

  defp match(image, num, index_h, index_v, coords, next_coords) do
    IO.inspect("match")
    [y11 | coords] = coords
    y12 = y11 + @line_width
    [y21 | coords] = coords
    y22 = y21 + @line_width
    x1 = @offx + @width + (index_h-1)*@line_length
    x2 = @offx + @width + (index_h-1)*@line_length + @line_length

    x3 = x2 - @line_width
    y = ((y11+y21)/2) |> round()

    next_coords = [y | next_coords]

    image
    |> custom("fill", "#707070")
    |> Mogrify.Draw.rectangle(x1, y11, x2, y12)
    |> Mogrify.Draw.rectangle(x1, y21, x2, y22)
    |> Mogrify.Draw.rectangle(x3, y11, x2, y22)
    |> plot(num, index_h, index_v+2, coords, next_coords)
  end

  defp go(image, num, index_h, index_v, coords, next_coords) do
    IO.inspect("go")
    [y1 | coords] = coords
    y2 = y1 + @line_width
    x1 = @offx + @width + (index_h-1)*@line_length
    x2 = @offx + @width + (index_h-1)*@line_length + @line_length

    next_coords = [y1 | next_coords]

    image
    |> custom("fill", "#707070")
    |> Mogrify.Draw.rectangle(x1, y1, x2, y2)
    |> plot(num, index_h, index_v+2, coords, next_coords)
  end

  defp proceed(image, num, index_h, _index_v, coords) do
    IO.inspect("proceed")
    IO.inspect(index_h)
    IO.inspect(Utils.block_index(num))
    if index_h == Utils.block_index(num) do
      IO.inspect("proceed ended")
      image
    else
      image
      |> plot(num, index_h+1, 0, coords)
    end
  end
end