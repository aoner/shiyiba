defmodule SkyWeb.AdControllerTest do
  use SkyWeb.ConnCase

  alias Sky.Accounts

  @create_attrs %{count: 42, done_count: 42, link: "some link", name: "some name"}
  @update_attrs %{count: 43, done_count: 43, link: "some updated link", name: "some updated name"}
  @invalid_attrs %{count: nil, done_count: nil, link: nil, name: nil}

  def fixture(:ad) do
    {:ok, ad} = Accounts.create_ad(@create_attrs)
    ad
  end

  describe "index" do
    test "lists all ads", %{conn: conn} do
      conn = get conn, ad_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Ads"
    end
  end

  describe "new ad" do
    test "renders form", %{conn: conn} do
      conn = get conn, ad_path(conn, :new)
      assert html_response(conn, 200) =~ "New Ad"
    end
  end

  describe "create ad" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, ad_path(conn, :create), ad: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ad_path(conn, :show, id)

      conn = get conn, ad_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Ad"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, ad_path(conn, :create), ad: @invalid_attrs
      assert html_response(conn, 200) =~ "New Ad"
    end
  end

  describe "edit ad" do
    setup [:create_ad]

    test "renders form for editing chosen ad", %{conn: conn, ad: ad} do
      conn = get conn, ad_path(conn, :edit, ad)
      assert html_response(conn, 200) =~ "Edit Ad"
    end
  end

  describe "update ad" do
    setup [:create_ad]

    test "redirects when data is valid", %{conn: conn, ad: ad} do
      conn = put conn, ad_path(conn, :update, ad), ad: @update_attrs
      assert redirected_to(conn) == ad_path(conn, :show, ad)

      conn = get conn, ad_path(conn, :show, ad)
      assert html_response(conn, 200) =~ "some updated link"
    end

    test "renders errors when data is invalid", %{conn: conn, ad: ad} do
      conn = put conn, ad_path(conn, :update, ad), ad: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Ad"
    end
  end

  describe "delete ad" do
    setup [:create_ad]

    test "deletes chosen ad", %{conn: conn, ad: ad} do
      conn = delete conn, ad_path(conn, :delete, ad)
      assert redirected_to(conn) == ad_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, ad_path(conn, :show, ad)
      end
    end
  end

  defp create_ad(_) do
    ad = fixture(:ad)
    {:ok, ad: ad}
  end
end
