ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Timesheet.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Timesheet.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Timesheet.Repo)

