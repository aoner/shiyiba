defmodule Sky.Plugs.RequireUser do
  @moduledoc """
  A `Plug` to redirect to `pages/index` if there is no current user
  """

  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import SkyWeb.Router.Helpers
  import SkyWeb.Session, only: [logged_in?: 1]

  def init(options), do: options

  def call(conn, _opts) do
    if logged_in?(conn) do
      conn
    else
      conn
      |> put_flash(:error, "登录后才能访问")
      |> redirect(to: user_path(conn, :new))
      |> halt()
    end
  end
end