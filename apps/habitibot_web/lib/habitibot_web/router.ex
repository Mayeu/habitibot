defmodule HabitibotWeb.Router do
  use HabitibotWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(Habitibot_web.Auth, repo: Repository)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", HabitibotWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)

    post("/session", SessionController, :create)

    get("/settings", SettingController, :index)
    post("/settings/toggle_quest_bot", SettingController, :toggle_quest_bot)
  end

  # Other scopes may use custom stacks.
  # scope "/api", HabitibotWeb do
  #   pipe_through :api
  # end
end
