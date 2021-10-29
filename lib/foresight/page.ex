defmodule Foresight.Page do
  @moduledoc """
  A struct to hold page meta data.

  The `%Page{}` struct is used to structure the meta data from the parsing process.
  """
  defstruct [:url, :title, :description, :image, :icon]
end
