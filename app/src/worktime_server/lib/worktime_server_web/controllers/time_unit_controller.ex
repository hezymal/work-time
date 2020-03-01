defmodule WorktimeServerWeb.TimeUnitController do
  use WorktimeServerWeb, :controller
  alias WorktimeServerWeb.Services.{TimeUnitService}

  def get(conn, %{"ident" => ident}) do
    case TimeUnitService.get(ident) do
      {:ok, result} -> json(conn, result)
      {:not_found} -> conn |> send_resp(404, "Unit '" <> ident <> "' not found")
    end
  end

  def list(conn, _params), do: json(conn, TimeUnitService.list())

  def new(conn, _params), do: json(conn, TimeUnitService.new())

  def start(conn, %{"ident" => ident}) do
    json(conn, TimeUnitService.start(ident))
  end

  def stop(conn, %{"ident" => ident}) do
    case TimeUnitService.stop(ident) do
      {:ok, unit} -> json(conn, unit)
      _ -> conn |> send_resp(204, "")
    end
  end

  def rename(conn, %{"ident" => ident, "name" => name}) do
    case TimeUnitService.rename(ident, name) do
      {:ok, unit} -> json(conn, unit)
      _ -> conn |> send_resp(204, "")
    end
  end

  def remove(conn, %{"ident" => ident}) do
    case TimeUnitService.remove(ident) do
      {:ok, unit} -> json(conn, unit)
      _ -> conn |> send_resp(204, "")
    end
  end
end
