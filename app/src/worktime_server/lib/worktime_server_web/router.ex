defmodule WorktimeServerWeb.Router do
  use WorktimeServerWeb, :router

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

  scope "/", WorktimeServerWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", WorktimeServerWeb do
    pipe_through :api

    get "/version", PageController, :version

    get "/list", TimeUnitController, :list
    get "/:ident", TimeUnitController, :get
    post "/start/:ident", TimeUnitController, :start
    put "/stop", TimeUnitController, :stop
    put "/rename/:ident/to/:name", TimeUnitController, :rename
    delete "/remove/:ident", TimeUnitController, :remove
  end
end
