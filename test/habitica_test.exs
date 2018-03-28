defmodule HabiticaTest do
  use ExUnit.Case, async: true

  import Mox

  # MAke sure mocks are verified on exist
  setup :verify_on_exit!

  setup_all do
    [
      conn: %Habitica.API.Connection{
        host: URI.parse("http://localhost:3000"),
        id: "0043256c-6e24-4bd4-8bc3-e8e97169c038",
        token: "2d0773ab-3484-48db-9852-86923c2eb8e4"
      }
    ]
  end

  doctest Habitica

  test "get the group of an user should trigger an api call", context do
    Habitica.API.Mock
    |> expect(:get_party, fn _ ->
      %{:data => %{:id => "49c07a85-71d5-45d9-8dec-c30d3795c29c"}}
    end)

    Habitica.get_party(context[:conn])
  end

  test "accept a quest", context do
    Habitica.API.Mock
    |> expect(:accept_quest, fn _ -> {:accepted, %{}} end)

    Habitica.accept_quest(context[:conn])
  end
end
