defmodule Timesheet.TimesheetControllerTest do
  use Timesheet.ConnCase

  alias Timesheet.Timesheet
  @valid_attrs %{category: "some content", checkout: true, name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, timesheet_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing timesheets"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, timesheet_path(conn, :new)
    assert html_response(conn, 200) =~ "New timesheet"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, timesheet_path(conn, :create), timesheet: @valid_attrs
    assert redirected_to(conn) == timesheet_path(conn, :index)
    assert Repo.get_by(Timesheet, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, timesheet_path(conn, :create), timesheet: @invalid_attrs
    assert html_response(conn, 200) =~ "New timesheet"
  end

  test "shows chosen resource", %{conn: conn} do
    timesheet = Repo.insert! %Timesheet{}
    conn = get conn, timesheet_path(conn, :show, timesheet)
    assert html_response(conn, 200) =~ "Show timesheet"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, timesheet_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    timesheet = Repo.insert! %Timesheet{}
    conn = get conn, timesheet_path(conn, :edit, timesheet)
    assert html_response(conn, 200) =~ "Edit timesheet"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    timesheet = Repo.insert! %Timesheet{}
    conn = put conn, timesheet_path(conn, :update, timesheet), timesheet: @valid_attrs
    assert redirected_to(conn) == timesheet_path(conn, :show, timesheet)
    assert Repo.get_by(Timesheet, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    timesheet = Repo.insert! %Timesheet{}
    conn = put conn, timesheet_path(conn, :update, timesheet), timesheet: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit timesheet"
  end

  test "deletes chosen resource", %{conn: conn} do
    timesheet = Repo.insert! %Timesheet{}
    conn = delete conn, timesheet_path(conn, :delete, timesheet)
    assert redirected_to(conn) == timesheet_path(conn, :index)
    refute Repo.get(Timesheet, timesheet.id)
  end
end
