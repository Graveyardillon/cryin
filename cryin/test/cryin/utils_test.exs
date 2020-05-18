defmodule Cryin.UtilsTest do
  use ExUnit.Case, async: true

  alias Cryin.Utils

  test "block_index() returns expected value" do
    assert Utils.block_index(1) == 1
    assert Utils.block_index(2) == 2
    assert Utils.block_index(3) == 3
    assert Utils.block_index(4) == 3
    assert Utils.block_index(5) == 4
    assert Utils.block_index(6) == 4
    assert Utils.block_index(7) == 4
    assert Utils.block_index(8) == 4
    assert Utils.block_index(9) == 5
    assert Utils.block_index(10) == 5
    assert Utils.block_index(11) == 5
    assert Utils.block_index(12) == 5
    assert Utils.block_index(13) == 5
    assert Utils.block_index(14) == 5
    assert Utils.block_index(15) == 5
    assert Utils.block_index(16) == 5
  end
end