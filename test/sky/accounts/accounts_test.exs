defmodule Sky.AccountsTest do
  use Sky.DataCase

  alias Sky.Accounts

  describe "users" do
    alias Sky.Accounts.User

    @valid_attrs %{mobile: "some mobile", name: "some name", password: "some password"}
    @update_attrs %{mobile: "some updated mobile", name: "some updated name", password: "some updated password"}
    @invalid_attrs %{mobile: nil, name: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.mobile == "some mobile"
      assert user.name == "some name"
      assert user.password == "some password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.mobile == "some updated mobile"
      assert user.name == "some updated name"
      assert user.password == "some updated password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "ads" do
    alias Sky.Accounts.Ad

    @valid_attrs %{count: 42, done_count: 42, link: "some link", name: "some name"}
    @update_attrs %{count: 43, done_count: 43, link: "some updated link", name: "some updated name"}
    @invalid_attrs %{count: nil, done_count: nil, link: nil, name: nil}

    def ad_fixture(attrs \\ %{}) do
      {:ok, ad} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_ad()

      ad
    end

    test "list_ads/0 returns all ads" do
      ad = ad_fixture()
      assert Accounts.list_ads() == [ad]
    end

    test "get_ad!/1 returns the ad with given id" do
      ad = ad_fixture()
      assert Accounts.get_ad!(ad.id) == ad
    end

    test "create_ad/1 with valid data creates a ad" do
      assert {:ok, %Ad{} = ad} = Accounts.create_ad(@valid_attrs)
      assert ad.count == 42
      assert ad.done_count == 42
      assert ad.link == "some link"
      assert ad.name == "some name"
    end

    test "create_ad/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_ad(@invalid_attrs)
    end

    test "update_ad/2 with valid data updates the ad" do
      ad = ad_fixture()
      assert {:ok, ad} = Accounts.update_ad(ad, @update_attrs)
      assert %Ad{} = ad
      assert ad.count == 43
      assert ad.done_count == 43
      assert ad.link == "some updated link"
      assert ad.name == "some updated name"
    end

    test "update_ad/2 with invalid data returns error changeset" do
      ad = ad_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_ad(ad, @invalid_attrs)
      assert ad == Accounts.get_ad!(ad.id)
    end

    test "delete_ad/1 deletes the ad" do
      ad = ad_fixture()
      assert {:ok, %Ad{}} = Accounts.delete_ad(ad)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_ad!(ad.id) end
    end

    test "change_ad/1 returns a ad changeset" do
      ad = ad_fixture()
      assert %Ecto.Changeset{} = Accounts.change_ad(ad)
    end
  end
end
