defmodule SkyWeb.PageController do
  use SkyWeb, :controller

  def index(conn, _params) do
    # conn
    # |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    # |> put_flash(:error, "Let's pretend we have an error.")
    # |> render("index.html")
    # render conn, "index.html"
    render conn, :index
  end
end
