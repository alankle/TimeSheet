defmodule Timesheet.TimesheetController do
  use Timesheet.Web, :controller

  alias Timesheet.Timesheet

  plug :scrub_params, "timesheet" when action in [:create, :update]

  def index(conn, _params) do
    timesheets = Repo.all(Timesheet)
    render(conn, "index.html", timesheets: timesheets)
  end

  def new(conn, _params) do
    changeset = Timesheet.changeset(%Timesheet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"timesheet" => timesheet_params}) do
    changeset = Timesheet.changeset(%Timesheet{}, timesheet_params)

    case Repo.insert(changeset) do
      {:ok, _timesheet} ->
        conn
        |> put_flash(:info, "Timesheet created successfully.")
        |> redirect(to: timesheet_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    timesheet = Repo.get!(Timesheet, id)
    render(conn, "show.html", timesheet: timesheet)
  end

  def edit(conn, %{"id" => id}) do
    timesheet = Repo.get!(Timesheet, id)
    changeset = Timesheet.changeset(timesheet)
    render(conn, "edit.html", timesheet: timesheet, changeset: changeset)
  end

  def search(conn, %{"name" => name}) do
      timesheet = Repo.get!(Timesheet, name)
      changeset = Timesheet.changeset(timesheet)
      render(conn, "index.html", timesheet: timesheet, changeset: changeset)
  end


  def update(conn, %{"id" => id, "timesheet" => timesheet_params}) do
    timesheet = Repo.get!(Timesheet, id)
    changeset = Timesheet.changeset(timesheet, timesheet_params)

    case Repo.update(changeset) do
      {:ok, timesheet} ->
        conn
        |> put_flash(:info, "Timesheet updated successfully.")
        |> redirect(to: timesheet_path(conn, :show, timesheet))
      {:error, changeset} ->
        render(conn, "edit.html", timesheet: timesheet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    timesheet = Repo.get!(Timesheet, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(timesheet)

    conn
    |> put_flash(:info, "Timesheet deleted successfully.")
    |> redirect(to: timesheet_path(conn, :index))
  end
end
