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
  end

  # Other scopes may use custom stacks.
  scope "/api", CryinWeb do
    pipe_through :api

    post "/image/gen/diagram", ImageController, :generate_diagram

    # DEBUG
    post "/debug/soft_corner", ImageController, :debug_soft_corner
    post "/debug/image/gen", ImageController, :debug_generate
  end
end
