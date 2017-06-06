defmodule ActionForChildren.Web.CssHelpersTest do
  use ExUnit.Case
  alias ActionForChildren.Web.CssHelpers

  test "formats a list of styles" do
    button_styles = CssHelpers.button()

    assert String.length(button_styles) > 0
  end
end
