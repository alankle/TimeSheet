defmodule Timesheet.TimesheetTest do
  use Timesheet.ModelCase

  alias Timesheet.Timesheet

  @valid_attrs %{category: "some content", checkout: true, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Timesheet.changeset(%Timesheet{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Timesheet.changeset(%Timesheet{}, @invalid_attrs)
    refute changeset.valid?
  end
end
