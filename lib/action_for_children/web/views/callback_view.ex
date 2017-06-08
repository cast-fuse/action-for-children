defmodule ActionForChildren.Web.CallbackView do
  use ActionForChildren.Web, :view

  def days, do: {["monday", "tuesday", "wednesday", "thursday"], ["friday", "saturday", "sunday", "any"]}
  def times, do: ["morning", "afternoon", "evening"]
  def day_conversions, do: %{"monday" => "mon",
                             "tuesday" => "tue",
                             "wednesday" => "wed",
                             "thursday" => "thurs",
                             "friday" => "fri",
                             "saturday" => "sat",
                             "sunday" => "sun",
                             "any" => "any"}
end
