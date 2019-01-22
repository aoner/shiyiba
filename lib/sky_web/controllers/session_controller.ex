defmodule SkyWeb.SessionController do
  use SkyWeb, :controller

  alias Sky.Accounts

  def new(conn, _params) do
    changeset = Accounts.signin_changeset
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    attrs = %{mobile: params["mobile"], password: params["password"]}
    case Accounts.signin(attrs) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "不试一把，你咱知道不行.")
        |> put_session(:current_user, user.id)
        |> redirect(to: user_path(conn, :show, user.mobile))
                        # user_path(conn, :show, current_user(@conn).mobile)
      # {:error, %Ecto.Changeset{} = changeset} ->
      #   conn
      #   |> put_flash(:danger, "Login Unsuccessful")
      #   |> render(:new, changeset: %{changeset | action: :create})
      {:error, reason} ->
        changeset = Accounts.signin_changeset()
        conn
        |> put_flash(:danger, reason)
        |> render(:new, changeset: changeset)
    end 
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end