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

  def grey_button do
    styles([
      "bg-light-gray", "hover-bg-red", "gray", "hover-white",
      "ba", "b--light-silver", "br3",
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

  defp styles(styles) do
    styles
    |> List.flatten()
    |> Enum.join(" ")
  end
end
