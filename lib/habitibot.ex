defmodule Habitibot do
  @moduledoc """
  Documentation for Habitibot.
  """
  @spec accept_quest(Habitica.API.Connection.t()) ::
          :ok | {:ok, :nothing_to_accept} | {:error, map}
  def accept_quest(conn) do
    {:ok, party} = Habitica.get_party(conn)

    if have_pending_quest?(party) do
      Habitica.accept_quest(conn)
    else
      {:ok, :nothing_to_accept}
    end
  end

  @doc """
  Given a party, return a boolean stating if there is a quest to start or not
  """
  @spec have_pending_quest?(map) :: boolean
  def have_pending_quest?(%{"quest" => %{"active" => false, "key" => quest_key}}), do: true
  def have_pending_quest?(_), do: false
end
