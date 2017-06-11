defmodule ActionForChildren.Callback do
  @moduledoc """
  non db backed changeset to validate the options in the callback form
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias ActionForChildren.Callback

  embedded_schema do
    field :phone
    field :time
    field :day
    field :topic
  end

  def changeset(%Callback{} = callback, params \\ %{}) do
    callback
    |> cast(params, [:phone, :time, :day, :topic])
    |> validate_required(:phone, message: "please enter your phone number")
    |> validate_required(:day, message: "please select a time of day")
    |> validate_required(:time, message: "please select a preferred time")
  end
end
