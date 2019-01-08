defmodule Sky.Accounts.User do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt

  alias Sky.Accounts.User


  # 数据结构
  schema "users" do
    field :mobile, :string
    field :name, :string
    field :avatar, Sky.Avatar.Type
    field :password, :string, virtual: true
    field :password_digest, :string
    field :age, :integer
    field :sex, :string
    field :province, :string
    field :city, :string
    field :address, :string
    timestamps()

    has_many :commodities, Sky.Shop.Commodity
  end

  def changeset(user, attrs) do
    permitted = [
      :mobile,
      :name,
      :avatar,
      :age,
      :sex,
      :province,
      :city,
      :address
    ]
    user
    |> cast(attrs, permitted)
    |> validate_required([:mobile])
  end

  @doc """
  用户登录 changeset
  iex(12)> User.login_changeset(user, %{mobile: "Asf", password: "asfasdfasf"})
  #Ecto.Changeset<
    action: nil,
    changes: %{mobile: "Asf", password: "asfasdfasf"},
    errors: [],
    data: #Sky.Accounts.User<>,
    valid?: true
  >
  """
  def login_changeset(user, attrs) do
    user
    |> cast(attrs, [:mobile, :password])
    |> validate_required([:mobile, :password])
    # |> validate_length(:mobile, is: 11)
    # |> validate_format(:mobile, ~r/\d{11}/, message: "手机号码输入错误")
    # |> validate_length(:password, min: 6, max: 15)
  end

  @doc """
  用户注册 changeset
  """
  def register_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:mobile, :password])
    |> validate_required([:mobile, :password])
    |> unique_constraint(:mobile)
    |> validate_format(:mobile, ~r/\d{11}/)
    |> validate_length(:password, min: 6, max: 15)
    |> validate_confirmation(:password, message: "密码两次输入不一至")
    |> hash_password
  end

  @doc """
  修改用户资料 changeset
  """
  def profile_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :age, :sex, :province, :city, :address])
    |> cast_attachments(attrs, [:avatar])
    |> validate_required([:name, :avatar, :age, :sex, :province, :city, :address])
    |> validate_exclusion(:name, ~w(admin superadmin 你大爷))
    |> validate_length(:name, min: 2, max: 10)
    |> validate_inclusion(:age, 18..70)
    |> validate_inclusion(:sex, ["男","女"])
    |> validate_length(:province, min: 3, max: 10)
    |> validate_length(:city, min: 2, max: 20)
    |> validate_length(:address, min: 5, max: 50)
  end
  
  def update_password_changeset(user, attrs) do
    user
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 15)
    |> validate_confirmation(:password, message: "密码两次输入不一至")
    |> hash_password
  end

  @doc """
  用户注册时密码加密
  iex(12)> User.login_changeset(user, %{mobile: "Asf", password: "asfasdfasf"})
  #Ecto.Changeset<
    action: nil,
    changes: %{mobile: "Asf", password: "asfasdfasf"},
    errors: [],
    data: #Sky.Accounts.User<>,
    valid?: true
  >
  """
  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} -> 
        put_change(changeset, :password_digest, hashpwsalt(password))
      _ ->
        changeset
    end
  end

  # def validate_user(%{valid?: false} = changeset) do
  #   {:error, changeset}
  # end
  
  # def validate_user(changeset) do
  #   with mobile   <- get_field(changeset, :mobile),
  #     password    <- get_field(changeset, :password),
  #     {:ok, user} <- Sky.Accounts.get_by_mobile(mobile),
  #     {:ok, user} <- valid_password(user, password)
  #   do
  #     {:ok, user}
  #   else
  #     {:error, message} -> {:error, add_error(changeset, :mobile, message)}
  #   end
  # end
end
