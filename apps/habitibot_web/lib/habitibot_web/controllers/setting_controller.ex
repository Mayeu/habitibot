defmodule HabitibotWeb.SettingController do
  use HabitibotWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def check_account(conn, %{"user" => %{"id" => user_id, "token" => api_token}}) do
    case Habitibot.check_user(%Habitica.API.Connection{
           host: Application.get_env(:habitibot_web, :habitica_api_url),
           id: user_id,
           token: api_token
         }) do
      {:ok, user_data} ->
        IO.inspect(user_data)

        conn
        |> put_session("user", %{
          id: user_id,
          token: api_token,
          name: user_data["profile"]["name"]
        })
        |> put_flash(:info, "Welcome #{user_data["profile"]["name"]}")
        |> redirect(to: setting_path(conn, :index))

      {:error, error_data} ->
        IO.inspect(error_data)

        conn
        |> put_flash(:error, "Wrong User ID and/or API token")
        |> redirect(to: page_path(conn, :index))
    end
  end

  def toggle_quest_bot(conn, _params) do
    render(conn, "index.html")
  end
end
