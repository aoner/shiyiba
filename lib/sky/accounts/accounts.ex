defmodule Sky.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Sky.Repo
  alias Sky.Accounts.User
  alias Comeonin.Bcrypt

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)
  def get_user(id), do: Repo.get(User, id)

  def find_user_by(clauses) do
    User
    |> Repo.get_by(clauses)
  end

  def find_user_by_mobile(mobile) do
    find_user_by(mobile: mobile)
  end

  # def get_by_mobile(mobile) do
  #   case Repo.get_by(User, mobile: mobile) do
  #     nil  -> {:error, "用户不存在"}
  #     user -> {:ok, user}
  #   end
  # end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.register_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  用户登录
  ## Examples

    iex> signin(%{mobile: "15881178979", password: "viaiving"})
    {:ok, %User{}}

    iex> signin(%{mobile: "15881178979", password: "bad_value"})
    {:error, "用户不存在或密码错误"}
  """
  def signin(attrs) do
    user = find_user_by_mobile(attrs.mobile)
    case check_user_password(user, attrs.password) do
      true -> {:ok, user}
      _ -> {:error, "帐号或密码错误"}
    end
  end

  @doc """
  用户修改密码
  ## Examples

    iex> update_user_password(user, %{current_passoword: "asf", password: "viaiving"})
    {:ok, %User{}}

    iex> update_user_password(ueser, %{mobile: "15881178979", password: "bad_value"})
    {:error, "用户不存在或密码错误"}
  """
  def update_user_password(user, attrs) do
    case check_user_password(user, attrs["current_password"]) do
      true ->
        user
        |> User.password_changeset(attrs)
        |> Repo.update()
      _ ->
        {:error, "当前密码无效"}
    end
  end

  @doc """
  验证用户密码是否正确
  ## Examples
    iex> check_user_password(user, password)
    true
  """
  defp check_user_password(user, password) do
    case user do
      nil -> false
      _ -> !is_nil(user.password_digest) && Bcrypt.checkpw(password, user.password_digest)
    end
  end

  @doc """
  修改用户个人资料
  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.profile_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  修改用户帐号
  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_account(%User{} = user, attrs) do
    user
    |> User.account_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def change_signup(attrs \\ %{}) do
    %User{}
    |> User.register_changeset(attrs)
  end

  @doc """
  Returns the user login changeset.
  """
  def signin_changeset(attrs \\ %{}) do
    User.login_changeset(%User{}, attrs)
  end
end
