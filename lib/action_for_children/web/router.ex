defmodule ActionForChildren.Web.Router do
  use ActionForChildren.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ActionForChildren.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/sessions", SessionController, only: [:create, :delete]
    resources "/users", UserController, only: [:show, :create]
  end
end
