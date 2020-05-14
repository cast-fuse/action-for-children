defmodule ActionForChildrenWeb.CssHelpers do
  @moduledoc """
  tachyons styles for common components
  """

  def red_button do
    styles([
      "white",
      "bg-dark-red",
      "bn",
      "br3",
      button()
    ])
  end

  def blue_button do
    styles([
      "white",
      "bg-navy",
      "bn",
      "br3",
      button()
    ])
  end

  def button do
    styles([
      "center",
      "f5",
      "ph4",
      "pv3",
      "outline-0",
      "pointer",
      "underline-hover",
      "grow",
      "t3",
      "all",
      "ease",
      "w-80-ns",
      "w-100",
      "shadow-1",
      "h3"
    ])
  end

  defp styles(styles) do
    styles
    |> List.flatten()
    |> Enum.join(" ")
  end
end
