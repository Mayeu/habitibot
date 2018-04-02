use Mix.Config

config :scheduler, Scheduler,
  jobs: [
    {"* * * * *", {Scheduler, :schedule_quest_acceptation, []}}
  ]
