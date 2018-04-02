defmodule HabitibotWeb.SessionController do
  use HabitibotWeb, :controller

  require Logger

  def create(conn, params = %{"user" => %{"id" => user_id, "token" => api_token}}) do
    Logger.debug("#{__MODULE__}: Session creation initiated")

    user_conn = %{id: user_id, token: api_token}

    case check_account(user_conn) do
      {:ok, habitica_data} ->
        Logger.debug("#{__MODULE__}: Account exist in Habitica")
        # Two scenario here:
        # - either we already have the user locally, and in that case we check for upgraded data only
        # - or we don't yet have the user, so we need to add it to our DB
        case check_user_exist_locally(user_conn) do
          {:ok, user} ->
            Logger.debug("#{__MODULE__}: User exist locally")
            # We login the user
            login_user(user, conn)

          :new_user ->
            Logger.info("#{__MODULE__}: A new user is connecting")
            # The user is a new user of habitibot
            user_conn
            |> create_account(habitica_data)
            |> login_user(conn)
        end

      {:error, error_data} ->
        Logger.info("#{__MODULE__}: Account does is rejected by Habitica")
        return_on_invalid_account(conn, params)
    end
  end

  def check_account(conn) do
    Habitibot.check_user(%Habitica.API.Connection{
      host: Application.get_env(:habitibot_web, :habitica_api_url),
      id: conn.id,
      token: conn.token
    })
  end

  defp return_on_invalid_account(conn, _params) do
    conn
    |> put_flash(:error, "Wrong User ID and/or API token")
    |> redirect(to: page_path(conn, :index))
  end

  defp create_account(conn, habitica_data) do
    new_user = %{
      user_id: conn.id,
      api_token: conn.token,
      username: habitica_data["profile"]["name"]
    }

    Repository.User.changeset(%Repository.User{}, new_user)
    |> Repository.insert()
    |> case do
      {:ok, user} ->
        user
    end
  end

  defp check_user_exist_locally(conn) do
    user = Repository.User |> Repository.get_by(user_id: conn.id)

    case user do
      nil ->
        :new_user

      user ->
        {:ok, user}
    end
  end

  defp login_user(user, conn) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
    |> put_flash(:info, "Welcome #{user.username}")
    |> redirect(to: setting_path(conn, :index))
  end
end
