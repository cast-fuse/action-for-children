defmodule ActionForChildren.Web.CallbackControllerTest do
  use ActionForChildren.Web.ConnCase

  setup %{conn: conn} = config do
    if user_id = config[:login_as] do
      user = insert_user(%{uuid: user_id})
      conn = assign(conn, :user, user)
      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  @valid_callback_form %{topic: "TESTING - IGNORE - DO NOT NEED TO REPLY",
                         phone: "TESTING - IGNORE - DO NOT NEED TO REPLY",
                         time: "TESTING - IGNORE - DO NOT NEED TO REPLY",
                         day: "TESTING - IGNORE - DO NOT NEED TO REPLY"}

  @invalid_callback_form %{topic: "TESTING - IGNORE - DO NOT NEED TO REPLY",
                           day: "TESTING - IGNORE - DO NOT NEED TO REPLY"}

  @existing_intercom_user "EAC31107"
  @non_existing_intecom_user "A234323"

  @tag login_as: @existing_intercom_user

  @tag login_as: @existing_intercom_user

  @tag login_as: @existing_intercom_user

  @tag login_as: @non_existing_intecom_user

end
