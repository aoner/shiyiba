defmodule Sky.ShopTest do
  use Sky.DataCase

  alias Sky.Shop

  describe "commodities" do
    alias Sky.Shop.Commodity

    @valid_attrs %{name: "some name", price: "120.5"}
    @update_attrs %{name: "some updated name", price: "456.7"}
    @invalid_attrs %{name: nil, price: nil}

    def commodity_fixture(attrs \\ %{}) do
      {:ok, commodity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shop.create_commodity()

      commodity
    end

    test "list_commodities/0 returns all commodities" do
      commodity = commodity_fixture()
      assert Shop.list_commodities() == [commodity]
    end

    test "get_commodity!/1 returns the commodity with given id" do
      commodity = commodity_fixture()
      assert Shop.get_commodity!(commodity.id) == commodity
    end

    test "create_commodity/1 with valid data creates a commodity" do
      assert {:ok, %Commodity{} = commodity} = Shop.create_commodity(@valid_attrs)
      assert commodity.name == "some name"
      assert commodity.price == Decimal.new("120.5")
    end

    test "create_commodity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shop.create_commodity(@invalid_attrs)
    end

    test "update_commodity/2 with valid data updates the commodity" do
      commodity = commodity_fixture()
      assert {:ok, commodity} = Shop.update_commodity(commodity, @update_attrs)
      assert %Commodity{} = commodity
      assert commodity.name == "some updated name"
      assert commodity.price == Decimal.new("456.7")
    end

    test "update_commodity/2 with invalid data returns error changeset" do
      commodity = commodity_fixture()
      assert {:error, %Ecto.Changeset{}} = Shop.update_commodity(commodity, @invalid_attrs)
      assert commodity == Shop.get_commodity!(commodity.id)
    end

    test "delete_commodity/1 deletes the commodity" do
      commodity = commodity_fixture()
      assert {:ok, %Commodity{}} = Shop.delete_commodity(commodity)
      assert_raise Ecto.NoResultsError, fn -> Shop.get_commodity!(commodity.id) end
    end

    test "change_commodity/1 returns a commodity changeset" do
      commodity = commodity_fixture()
      assert %Ecto.Changeset{} = Shop.change_commodity(commodity)
    end
  end
end
