defmodule ActionForChildren.Web.CssHelpers do
  @moduledoc """
  tachyons styles for common components
  """

  def red_button do
    styles([
      "white", "bg-dark-red", "hover-bg-red",
      "bn", "br3",
      button()
    ])
  end

  def button do
    styles([
      "center",
      "f5", "tracked",
      "ph4", "pv3",
      "outline-0", "pointer",
      "t3", "all", "ease"
    ])
  end

  def home_tiles do
    styles([
      "w-100", "w-30-m",
      "tc", "flex", "flex-column",
      "items-center", "b--dark-red", "br4",
      "bw2", "b--solid", "pv4", "ph1",
      "mv2"
    ])
  end

  defp styles(styles) do
    styles
    |> List.flatten()
    |> Enum.join(" ")
  end
end
