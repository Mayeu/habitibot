defmodule Habitica.API do
  @callback get_party(conn :: Habitica.API.Connection.t()) :: {:ok, map} | {:error, map}
  @callback accept_quest(conn :: Habitica.API.Connection.t()) ::
              :ok | {:ok, :nothing_to_accept} | {:error, map} | {:already_accepted, map}
end

defmodule Habitica.API.Connection do
  @moduledoc """
  Define a connection structure that will be used everywhere.
  """
  @enforce_keys [:id, :token]
  defstruct host: URI.parse("https://habitica.com/"), id: nil, token: nil
  @type t :: %Habitica.API.Connection{host: URI.t(), id: String.t(), token: String.t()}
end

defmodule Habitica.API.HTTP do
  @behaviour Habitica.API

  @api_path "api/v3"

  def get_party(conn) do
    url = conn.host |> URI.merge("#{@api_path}/groups/party") |> to_string

    headers = [
      "Content-Type": "application/json",
      "x-api-user": conn.id,
      "x-api-key": conn.token
    ]

    {:ok, response} = HTTPoison.get(url, headers)
    body = Poison.decode!(response.body)
    data = body["data"]

    case response do
      %HTTPoison.Response{status_code: 200} ->
        {:ok, data}

      %HTTPoison.Response{status_code: 404} ->
        {:error, body}

      %HTTPoison.Response{status_code: 400} ->
        {:error, body}
    end
  end

  def accept_quest(conn) do
    url = conn.host |> URI.merge("#{@api_path}/groups/party/quests/accept") |> to_string

    headers = [
      "Content-Type": "application/json",
      "x-api-user": conn.id,
      "x-api-key": conn.token
    ]

    {:ok, response} = HTTPoison.post(url, Poison.encode!(%{"groupId" => "party"}), headers)
    body = Poison.decode!(response.body)
    data = body["data"]

    case response do
      %HTTPoison.Response{status_code: 200} ->
        :ok

      # {"success":false,"error":"BadRequest","message":"You already accepted the quest invitation."}%
      %HTTPoison.Response{status_code: 404} ->
        case(body) do
          %{"error" => "BadRequest"} ->
            # This mean that either there is no quest to accept, or the quest is already accepted
            {:ok, :nothing_to_accept}

          _ ->
            {:error, body}
        end

      %HTTPoison.Response{status_code: 401} ->
        case(body) do
          %{"error" => "NotAuthorized"} ->
            # This mean that either there is no quest to accept, or the quest is already accepted
            {:ok, :nothing_to_accept}

          _ ->
            {:error, body}
        end
    end
  end
end
