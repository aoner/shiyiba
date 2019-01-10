defmodule SkyWeb.UserController do
  use SkyWeb, :controller
  alias Sky.Accounts
  plug :put_layout, "user.html"
  plug Sky.Plugs.RequireUser when action in [:index, :show]

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_signup
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    case Accounts.create_user(params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, _params) do
    user = current_user(conn) #Accounts.find_user_by_mobile(id)
    render(conn, "show.html", user: user)
    # render(conn, :show,
    #   user: user,
    #   topics: topics,
    #   replies: replies
    # )
  end

  # def edit(conn) do
  #   # user = Accounts.get_user!(id)
  #   changeset = Accounts.change_user(current_user(conn))
  #   render(conn, "edit.html", changeset: changeset)
  #   # render(conn, "edit.html", user: user, changeset: changeset)
  # end

  # %{"user" => params} = %{"_csrf_token" => "PS4JUC8bFjJbGR89fiptYy1zO0BWJgAAGez5XLQWniPK+hB6l6L41A==", "_method" => "put", "_utf8" => "✓", "id" => "5", "user" => %{"address" => "\b金牛区金府路889号中加水岸9幢2903", "age" => "21", "city" => "成都市", "mobile" => "15881178970", "name" => "六月", "province" => "四川省", "sex" => "男"}
  # @spec update(Plug.Conn.t(), map()) :: Plug.Conn.t()
  # def update(conn, %{"user" => params}) do
  #   # user = Accounts.get_user!(id)

  #   case Accounts.update_user(current_user(conn), params) do
  #     {:ok, user} ->
  #       conn
  #       |> put_flash(:info, "User updated successfully.")
  #       # |> redirect(to: user_path(conn, :show, user))
  #       |> render(:show, changeset: Accounts.change_user(user))
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       # render(conn, "edit.html", user: current_user(conn), changeset: changeset)
  #       conn
  #       |> put_flash(:danger, gettext("Profile updated failed"))
  #       |> render(:show, changeset: changeset)
  #   end
  # end

  # @spec delete(any(), any()) :: none()
  # def delete(conn, _) do
  #   user = current_user(conn)
  #   # Accounts.get_user!(id)
  #   {:ok, _user} = Accounts.delete_user(user)

  #   conn
  #   |> put_flash(:info, "User deleted successfully.")
  #   |> redirect(to: signin_path(conn, :index))
  # end
end
