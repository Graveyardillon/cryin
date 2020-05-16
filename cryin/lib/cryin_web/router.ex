defmodule CryinWeb.Router do
  use CryinWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CryinWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", CryinWeb do
    pipe_through :api

    post "/image/gen", ImageController, :generate
    post "/image/rects", ImageController, :generate_rects
  end
end
