defmodule Cryin.Utils do
  def block_index(num), do: get_index(num)
  defp get_index(num, count \\ 1) do
    if num == 1 do
      count
    else
      next_num = round(num/2)
      get_index(next_num, count+1)
    end
  end
end