defmodule SkyWeb.SettingController do
  use SkyWeb, :controller

  alias Sky.Accounts
  plug Sky.Plugs.RequireUser # when action in [:index, :show]
  # @intercepted_action ~w(show account password profile)a

  # def action(conn, _) do
  #   if Enum.member?(@intercepted_action, action_name(conn)) do
  #     changeset = Accounts.change_user(current_user(conn))
  #     render(conn, action_name(conn), changeset: changeset)
  #   else
  #     apply(__MODULE__, action_name(conn), [conn, conn.params])
  #   end
  # end
  def profile(conn, _) do
    changeset = Accounts.change_user(current_user(conn))
    render(conn, "profile.html", changeset: changeset)
  end

  def account(conn, _) do
    changeset = Accounts.change_user(current_user(conn))
    render(conn, "account.html", changeset: changeset)
  end

  def password(conn, _) do
    changeset = Accounts.change_user(current_user(conn))
    render(conn, "password.html", changeset: changeset)
  end

  def update(conn, %{"user" => params}) do
    case params["type"] do
      "profile" -> update_profile(conn, params)
      "account" -> update_account(conn, params)
      "password" -> update_password(conn, params)
    end
  end

  # %{"user" => params} = %{"_csrf_token" => "PS4JUC8bFjJbGR89fiptYy1zO0BWJgAAGez5XLQWniPK+hB6l6L41A==", "_method" => "put", "_utf8" => "✓", "id" => "5", "user" => %{"address" => "\b金牛区金府路889号中加水岸9幢2903", "age" => "21", "city" => "成都市", "mobile" => "15881178970", "name" => "六月", "province" => "四川省", "sex" => "男"}
  def update_profile(conn, params) do
    case Accounts.update_user(current_user(conn), params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Profile updated successfully.")
        |> render(:profile, changeset: Accounts.change_user(user))
        # |> redirect(to: setting_profile_path(conn, :profile))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:danger, gettext("Profile updated failed"))
        |> render(:profile, changeset: changeset)
    end
  end

  def update_account(conn, params) do
    case Accounts.update_user(current_user(conn), params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "帐号更新成功")
        # |> render(:account, changeset: Accounts.change_user(user))
        |> redirect(to: setting_account_path(conn, :account))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:danger, gettext("帐号更新失败"))
        |> render(:account, changeset: changeset)
    end
  end

  def update_password(conn, params) do
    case Accounts.update_user_password(current_user(conn), params) do
      {:ok, user} ->
        conn
        |> configure_session(drop: true)
        |> put_flash(:info, "密码更新成功")
        |> redirect(to: setting_profile_path(conn, :profile))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:danger, "新密码无效")
        |> render(:password, changeset: changeset)
      {:error, reason} ->
        changeset = Accounts.user_update_password_changeset()

        conn
        |> put_flash(:danger, reason)
        |> redirect(to: setting_password_path(conn, :password))
        # |> render(:password, changeset: changeset)
    end
  end
end
