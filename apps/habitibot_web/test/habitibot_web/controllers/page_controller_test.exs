defmodule HabitibotWeb.PageControllerTest do
  use HabitibotWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Habitibot"
  end
end
