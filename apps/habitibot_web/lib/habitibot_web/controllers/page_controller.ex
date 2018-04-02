defmodule HabitibotWeb.PageController do
  use HabitibotWeb, :controller

  def index(conn, _params) do
    case authenticate(conn) do
      %Plug.Conn{halted: true} = conn ->
        conn
        |> render("index.html")

      conn ->
        conn
        |> redirect(to: setting_path(conn, :index))
    end
  end

  defp authenticate(conn) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> halt()
    end
  end
end
