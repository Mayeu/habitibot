defmodule HabitibotWeb.PageController do
  use HabitibotWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
