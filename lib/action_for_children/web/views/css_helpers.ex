defmodule ActionForChildren.Web.CssHelpers do
  @moduledoc """
  tachyons styles for common components
  """

  def red_button do
    styles([
      "white", "bg-dark-red", "hover-bg-red",
      "bn", "br3", "w-80-l",
      button()
    ])
  end

  def white_button do
    styles([
      "red", "bg-white", "hover-bg-white",
      "bn", "br3",
      button()
    ])
  end

  def button do
    styles([
      "center",
      "f5",
      "ph4", "pv3",
      "outline-0", "pointer",
      "t3", "all", "ease"
    ])
  end

  def home_tiles do
    styles([
      "w-80", "w-35-m",
      "tc", "flex", "flex-column",
      "items-center", "b--dark-red", "br4",
      "bw1", "b--solid", "pv4", "ph1",
      "mv2", "home_tile"
    ])
  end

  defp styles(styles) do
    styles
    |> List.flatten()
    |> Enum.join(" ")
  end
end
