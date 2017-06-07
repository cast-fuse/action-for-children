defmodule ActionForChildren.Web.IntercomTest do
  use ExUnit.Case
  import Mock
  alias ActionForChildren.Web.{IntercomPrefferedTimes, IntercomRequest, IntercomRequestMock}

  defmacro with_request_mock(block) do
    quote do
      with_mock IntercomRequest, [post: fn(url, payload) -> IntercomRequestMock.post(url, payload) end] do
        unquote(block)
      end
    end
  end

  test "sending a preffered times to a user" do
    with_request_mock do
      message = "hello intercom"
      {:ok, :message_sent, res} = IntercomPrefferedTimes.send_preferred_times(%{user_id: "ACD12345", message: message})

      assert res["body"] == message
      assert res["type"] == "user_message"
    end
  end

  test "returns error if user not found" do
    with_request_mock do
      message = "hello intercom"
      {:error, reason} = IntercomPrefferedTimes.send_preferred_times(%{user_id: "wrong id", message: message})
      %{"errors" => [errors], "type" => type} = reason

      assert type == "error.list"
      assert Map.get(errors, "code") == "not_found"
      assert Map.get(errors, "message") == "User Not Found"
    end
  end

  test "returns error if bad request made" do
    with_request_mock do
      {:error, reason} = IntercomPrefferedTimes.send_preferred_times(%{user_id: "foo", message: %{bad: "message"}})

      assert reason == :http_client_error
    end
  end
end
