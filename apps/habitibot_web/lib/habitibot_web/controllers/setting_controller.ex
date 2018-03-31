defmodule HabitibotWeb.SettingController do
  use HabitibotWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def toggle_quest_bot(conn, _params) do
    render(conn, "index.html")
  end
end
