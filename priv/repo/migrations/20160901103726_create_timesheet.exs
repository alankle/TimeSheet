defmodule Timesheet.Repo.Migrations.CreateTimesheet do
  use Ecto.Migration

  def change do
    create table(:timesheets) do
      add :name, :string
      add :category, :string
      add :checkout, :boolean, default: false

      timestamps
    end

  end
end
