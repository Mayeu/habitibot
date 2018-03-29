defmodule HabiticaLocalhostTest do
  use ExUnit.Case

  @moduletag :localhost

  setup_all do
    [
      habitica_api: Habitica.API.HTTP,
      conn_one: %Habitica.API.Connection{
        host: URI.parse("http://localhost:3000"),
        id: "02a1173f-30da-4cab-a386-fc9dea965853",
        token: "630c5e34-8788-4d9e-a77f-4267ebaee31d"
      },
      conn_two: %Habitica.API.Connection{
        host: URI.parse("http://localhost:3000"),
        id: "cc92fb3a-bf43-4099-9818-3070b170a84c",
        token: "19881291-88a6-4b20-b7ac-5e33a1f0fe0d"
      }
    ]
  end

  test "get User2's group", context do
    {:ok, party} = context[:habitica_api].get_party(context[:conn_one])

    assert party["id"] == "1be5ceb8-6bc6-4353-845f-9c07aff259d5"
    assert party["leader"]["id"] == context[:conn_two].id
  end

  test "it should be possible to accept a pending quest", context do
    assert context[:habitica_api].accept_quest(context[:conn_one]) == :ok
  end

  test "it should not be possible to reaccept a pending quest", context do
    assert context[:habitica_api].accept_quest(context[:conn_one]) == {:ok, :nothing_to_accept}
  end
end
