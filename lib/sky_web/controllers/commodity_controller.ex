defmodule SkyWeb.CommodityController do
  use SkyWeb, :controller

  alias Sky.Shop
  alias Sky.Shop.Commodity

  def index(conn, _params) do
    commodities = Shop.all()
    render(conn, "index.html", commodities: commodities)
  end

  def new(conn, _params) do
    changeset = Shop.change_commodity(%Commodity{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"commodity" => commodity_params}) do
    case Shop.create_commodity(commodity_params) do
      {:ok, commodity} ->
        conn
        |> put_flash(:info, "Commodity created successfully.")
        |> redirect(to: commodity_path(conn, :show, commodity))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    commodity = Shop.get_commodity!(id)
    render(conn, "show.html", commodity: commodity)
  end

  def edit(conn, %{"id" => id}) do
    commodity = Shop.get_commodity!(id)
    changeset = Shop.change_commodity(commodity)
    render(conn, "edit.html", commodity: commodity, changeset: changeset)
  end

  def update(conn, %{"id" => id, "commodity" => commodity_params}) do
    commodity = Shop.get_commodity!(id)

    case Shop.update_commodity(commodity, commodity_params) do
      {:ok, commodity} ->
        conn
        |> put_flash(:info, "Commodity updated successfully.")
        |> redirect(to: commodity_path(conn, :show, commodity))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", commodity: commodity, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    commodity = Shop.get_commodity!(id)
    {:ok, _commodity} = Shop.delete_commodity(commodity)

    conn
    |> put_flash(:info, "Commodity deleted successfully.")
    |> redirect(to: commodity_path(conn, :index))
  end
end
