defmodule Timesheet.Timesheet do
  use Timesheet.Web, :model

  schema "timesheets" do
    field :name, :string
    field :category, :string
    field :checkout, :boolean, default: false

    timestamps
  end

  @required_fields ~w(name category checkout)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
