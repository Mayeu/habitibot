defmodule Habitica do
  @habitica_api Application.get_env(:habitibot, :habitica_api)

  def get_party(conn), do: @habitica_api.get_party(conn)
  def accept_quest(conn), do: @habitica_api.accept_quest(conn)
  def get_user_data(conn), do: @habitica_api.get_user_data(conn)
end
