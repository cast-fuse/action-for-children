defmodule ActionForChildrenWeb.CallbackViewTest do
  use ActionForChildrenWeb.ConnCase
  alias ActionForChildrenWeb.CallbackView

  test "abbreviates days correctly" do
    assert CallbackView.abbreviate_day("monday") == "mon"
    assert CallbackView.abbreviate_day("tuesday") == "tues"
    assert CallbackView.abbreviate_day("wednesday") == "wed"
    assert CallbackView.abbreviate_day("thursday") == "thurs"
  end
end
