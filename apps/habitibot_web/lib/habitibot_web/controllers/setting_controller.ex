defmodule HabitibotWeb.SettingController do
  require Logger
  use HabitibotWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", user: @current_user)
  end

  def toggle_quest_bot(conn, %{"quest_bot" => %{"state" => string_state}}) do
    if string_state == "true" do
      state = true
    else
      state = false
    end

    Repository.User.changeset(conn.assigns.current_user, %{:quest_bot => state})
    |> Repository.update()
    |> case do
      {:ok, user} ->
        if user.quest_bot do
          message = "Quest bot activated."
        else
          message = "Quest bot deactivated."
        end

        conn
        |> put_flash(:info, message)
        |> redirect(to: setting_path(conn, :index))

      {:error, changeset} ->
        Logger.warn("#{__MODULE__}: #{changeset.errors}")

        conn
        |> put_flash(
          :error,
          "Error, impossible to save your settings. An admin has been dispatched."
        )
        |> redirect(to: setting_path(conn, :index))
    end
  end
end
