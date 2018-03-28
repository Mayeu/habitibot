defmodule HabitibotTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  doctest Habitibot

  setup_all do
    [
      conn: %Habitica.API.Connection{
        host: URI.parse("http://localhost:3000"),
        id: "0043256c-6e24-4bd4-8bc3-e8e97169c038",
        token: "2d0773ab-3484-48db-9852-86923c2eb8e4"
      },
      party_no_quest: %{
        "_id" => "1be5ceb8-6bc6-4353-845f-9c07aff259d5",
        "balance" => 0,
        "challengeCount" => 0,
        "chat" => [],
        "id" => "1be5ceb8-6bc6-4353-845f-9c07aff259d5",
        "leader" => %{
          "_id" => "cc92fb3a-bf43-4099-9818-3070b170a84c",
          "id" => "cc92fb3a-bf43-4099-9818-3070b170a84c",
          "profile" => %{"name" => "User2"}
        },
        "leaderOnly" => %{"challenges" => false},
        "memberCount" => 2,
        "name" => "User2's Party",
        "privacy" => "private",
        "purchased" => %{},
        "quest" => %{
          "active" => false,
          "extra" => %{},
          "members" => %{},
          "progress" => %{"collect" => %{}}
        },
        "tasksOrder" => %{
          "dailys" => [],
          "habits" => [],
          "rewards" => [],
          "todos" => []
        },
        "type" => "party"
      },
      party_quest_started: %{
        "_id" => "1be5ceb8-6bc6-4353-845f-9c07aff259d5",
        "balance" => 0,
        "challengeCount" => 0,
        "chat" => [
          %{
            "flagCount" => 0,
            "flags" => %{},
            "id" => "f966842d-807f-4e28-81ac-19675c60eb12",
            "likes" => %{},
            "text" => "Your quest, The Feral Dust Bunnies, has started.",
            "timestamp" => 1_522_316_313_562,
            "uuid" => "system"
          }
        ],
        "id" => "1be5ceb8-6bc6-4353-845f-9c07aff259d5",
        "leader" => %{
          "_id" => "cc92fb3a-bf43-4099-9818-3070b170a84c",
          "id" => "cc92fb3a-bf43-4099-9818-3070b170a84c",
          "profile" => %{"name" => "User2"}
        },
        "leaderOnly" => %{"challenges" => false},
        "memberCount" => 2,
        "name" => "User2's Party",
        "privacy" => "private",
        "purchased" => %{},
        "quest" => %{
          "active" => true,
          "extra" => %{},
          "key" => "dustbunnies",
          "leader" => "02a1173f-30da-4cab-a386-fc9dea965853",
          "members" => %{
            "02a1173f-30da-4cab-a386-fc9dea965853" => true,
            "cc92fb3a-bf43-4099-9818-3070b170a84c" => true
          },
          "progress" => %{"collect" => %{}, "hp" => 100}
        },
        "tasksOrder" => %{"dailys" => [], "habits" => [], "rewards" => [], "todos" => []},
        "type" => "party"
      },
      party_quest_pending: %{
        "_id" => "1be5ceb8-6bc6-4353-845f-9c07aff259d5",
        "balance" => 0,
        "challengeCount" => 0,
        "chat" => [],
        "id" => "1be5ceb8-6bc6-4353-845f-9c07aff259d5",
        "leader" => %{
          "_id" => "cc92fb3a-bf43-4099-9818-3070b170a84c",
          "id" => "cc92fb3a-bf43-4099-9818-3070b170a84c",
          "profile" => %{"name" => "User2"}
        },
        "leaderOnly" => %{"challenges" => false},
        "memberCount" => 2,
        "name" => "User2's Party",
        "privacy" => "private",
        "purchased" => %{},
        "quest" => %{
          "active" => false,
          "extra" => %{},
          "key" => "dustbunnies",
          "leader" => "02a1173f-30da-4cab-a386-fc9dea965853",
          "members" => %{
            "02a1173f-30da-4cab-a386-fc9dea965853" => true,
            "cc92fb3a-bf43-4099-9818-3070b170a84c" => nil
          },
          "progress" => %{"collect" => %{}}
        },
        "tasksOrder" => %{"dailys" => [], "habits" => [], "rewards" => [], "todos" => []},
        "type" => "party"
      }
    ]
  end

  test "have_pending_quest? should fail when there is no quest", context do
    refute Habitibot.have_pending_quest?(context[:party_no_quest])
  end

  test "have_pending_quest? should fail when a quest is running", context do
    refute Habitibot.have_pending_quest?(context[:party_quest_started])
  end

  test "have_pending_quest? should succeed when there is a pending quest not accepted", context do
    assert Habitibot.have_pending_quest?(context[:party_quest_pending])
  end

  test "accept quest should return :ok if a quest is accepted", context do
    Habitica.API.Mock
    |> expect(:get_party, fn _ ->
      {:ok, %{"quest" => %{"active" => false, "key" => "dustbunnies"}}}
    end)
    |> expect(:accept_quest, fn _ -> :ok end)

    assert Habitibot.accept_quest(context[:conn]) == :ok
  end
end
