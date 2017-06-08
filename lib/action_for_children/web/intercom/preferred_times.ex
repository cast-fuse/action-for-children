defmodule ActionForChildren.Web.IntercomPrefferedTimes do
  alias ActionForChildren.Web.IntercomRequest

  def send_preferred_times(%{user_id: user_id, message: message}) do
    payload = %{
      from: %{type: "user", user_id: user_id},
      body: message
    }

    IntercomRequest.post("/messages", payload)
    |> handle_response()
  end

  def format_message(%{"topic" => topic, "time" => time, "day" => day, "phone" => phone}) do
    "Hi there, can I get a callback on #{day} in the #{time}? My number is #{phone} and I'd like to talk about - #{topic}"
  end

  defp handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, :message_sent, Poison.Parser.parse!(body)}
  end

  defp handle_response({:ok, %{status_code: _, body: body}}) do
    {:error, Poison.Parser.parse!(body)}
  end

  defp handle_response({:error, _}) do
    {:error, :http_client_error}
  end
end
