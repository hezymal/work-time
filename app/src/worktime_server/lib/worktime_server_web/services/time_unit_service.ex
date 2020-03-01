defmodule WorktimeServerWeb.Services.TimeUnitService do
  import Ecto.Query
  import UUID
  alias WorktimeServer.{Repo, TimeUnit, TimeUnitTransition}

  def new() do
    name = uuid4(:hex)
    {:ok, unit} = Repo.insert(%TimeUnit{:name => name})
    Repo.insert(%TimeUnitTransition{:time_unit_id => unit.id, :kind => "start"})
    unit
  end

  def start(ident) do
    current = get_current()
    unit = get_by_ident(ident)
    if is_nil(unit) do
      case insert_unit(ident) do
        {:ok, unit}       -> switch_units(current, unit)
        {:error, message} -> {:error, message}
      end
    else
      switch_units(current, unit)
    end
  end

  def stop(ident), do: stop_unit(get_by_ident(ident))

  def stop_current(), do: stop_unit(get_current())

  def list, do: Repo.all(from(u in TimeUnit))

  def get(ident) do
    unit = get_by_ident(ident)
    if is_nil(unit) do
      {:not_found}
    else
      query = from u in TimeUnitTransition, where: u.time_unit_id == ^unit.id
      transitions = Repo.all(query)
      {:ok, %{"unit" => unit, "transitions" => transitions}}
    end
  end

  def get_current() do
    query = from u in TimeUnitTransition, order_by: [desc: u.inserted_at]
    last_transition = query |> first |> Repo.one
    get_by_id(last_transition.time_unit_id)
  end

  def remove(ident) do
    unit = get_by_ident(ident)

    if !is_nil(unit) do
      Repo.delete(unit)
      Repo.delete_all(from u in TimeUnitTransition, where: u.time_unit_id == ^unit.id)
      {:ok, unit}
    else
      # TODO: test this case
      {:error}
    end
  end

  def rename(ident, name) do
    unit = get_by_ident(ident)

    if !is_nil(unit) do
      entity = Repo.get!(TimeUnit, unit.id)
      entity = Ecto.Changeset.change(entity, name: name)
      Repo.update(entity)
    else
      # TODO: test this case
      {:error}
    end
  end

  defp ident_to_id(ident) do
    case Integer.parse(ident) do
      {id, ""} -> {:ok, id}
      _ -> {:error}
    end
  end

  defp get_by_ident(ident) do
    query =
      case ident_to_id(ident) do
        {:ok, id} -> from u in TimeUnit, where: u.id == ^id
        _ -> from u in TimeUnit, where: u.name == ^ident
      end

    Repo.one(query)
  end

  defp get_by_id(id) do
    query = from u in TimeUnit, where: u.id == ^id
    query |> first |> Repo.one
  end

  def stop_unit(unit) do
    if !is_nil(unit) do
      Repo.insert(%TimeUnitTransition{:time_unit_id => unit.id, :kind => "stop"})
      {:ok, unit}
    else
      {:error}
    end
  end

  defp switch_units(from_unit, to_unit) do
    if from_unit.id != to_unit.id do
      with  {:ok, _} <- insert_transition(from_unit.id, "stop"),
            {:ok, _} <- insert_transition(to_unit.id, "start") do
        {:ok, to_unit}
      else
        {:error, message} -> {:error, message}
      end
    else
      {:error, "Unit " <> to_unit.name <> " is already running"}
    end
  end

  defp insert_unit(name) do
    unit = %TimeUnit{:name => name}
    case Repo.insert unit do
      {:ok, unit} -> {:ok, unit}
      {:error, _} -> {:error, "Cannot insert unit to database"}
    end
  end

  defp insert_transition(unit_id, kind) do
    transition = %TimeUnitTransition{:time_unit_id => unit_id, :kind => kind}
    case Repo.insert transition do
      {:ok, transition} -> {:ok, transition}
      {:error, _}       -> {:error, "Cannot insert transition to database"}
    end
  end
end
