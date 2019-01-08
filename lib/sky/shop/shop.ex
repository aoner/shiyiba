defmodule Sky.Shop do
  @moduledoc """
  The Shop context.
  """

  import Ecto.Query, warn: false
  alias Sky.Repo

  alias Sky.Shop.Commodity

  @doc """
  Returns the list of commodities.

  ## Examples

      iex> list_commodities()
      [%Commodity{}, ...]

  """
  def all do
    Repo.all(Commodity)
  end

  @doc """
  Gets a single commodity.

  Raises `Ecto.NoResultsError` if the Commodity does not exist.

  ## Examples

      iex> get_commodity!(123)
      %Commodity{}

      iex> get_commodity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_commodity!(id), do: Repo.get!(Commodity, id)

  @doc """
  Creates a commodity.

  ## Examples

      iex> create_commodity(%{field: value})
      {:ok, %Commodity{}}

      iex> create_commodity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_commodity(attrs \\ %{}) do
    %Commodity{}
    |> Commodity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a commodity.

  ## Examples

      iex> update_commodity(commodity, %{field: new_value})
      {:ok, %Commodity{}}

      iex> update_commodity(commodity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_commodity(%Commodity{} = commodity, attrs) do
    commodity
    |> Commodity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Commodity.

  ## Examples

      iex> delete_commodity(commodity)
      {:ok, %Commodity{}}

      iex> delete_commodity(commodity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_commodity(%Commodity{} = commodity) do
    Repo.delete(commodity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking commodity changes.

  ## Examples

      iex> change_commodity(commodity)
      %Ecto.Changeset{source: %Commodity{}}

  """
  def change_commodity(%Commodity{} = commodity) do
    Commodity.changeset(commodity, %{})
  end
end
