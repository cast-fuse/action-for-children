defmodule ActionForChildrenWeb.Router do
  use ActionForChildrenWeb, :router
  alias ActionForChildrenWeb.Plugs.Version

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Version
  end

  pipeline :api do
    plug CORSPlug,
      origin: [
        "https://megalodon-seabass-gaan.squarespace.com",
        "https://advice.actionforchildren.org.uk",
        "https://wwww.advice.actionforchildren.org.uk"
      ]

    plug :accepts, ["json"]
  end

  scope "/", ActionForChildrenWeb do
    # Use the default browser stack
    pipe_through :browser

    get "/", PageController, :index
    get "/practitioners", PageController, :practitioners
    get "/privacy", PageController, :privacy
    get "/verify", PageController, :verify
    get "/talk-to-us", PageController, :talk_to_us
    get "/feedback", PageController, :feedback

    get "/new-code", UserController, :new_code
    post "/generate-new-code", UserController, :generate_new_code

    post "/sign-in", SessionController, :create
    get "/logout", SessionController, :delete
    get "/token", SessionController, :create_from_token

    resources "/users", UserController, only: [:index, :create] do
      get "/callback", CallbackController, :show
      post "/callback", CallbackController, :create
    end
  end

  scope "/api", ActionForChildrenWeb do
    pipe_through :api

    post "/advice-login", SessionController, :advice_login
  end
end
