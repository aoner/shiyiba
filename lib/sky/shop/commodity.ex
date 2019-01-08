defmodule Sky.Shop.Commodity do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset


  schema "commodities" do
    field :name, :string
    field :price, :decimal
    field :icon, SkyWeb.IconUploader.Type
    field :count, :integer
    field :summary, :string
    timestamps()

    belongs_to :user, Sky.Accounts.User
  end

  @doc false
  def changeset(commodity, attrs) do
    commodity
    |> cast(attrs, [:user_id, :name, :price, :count, :summary])
    |> cast_attachments(attrs, [:icon])
    |> validate_required([:user_id, :name, :icon, :price, :count, :summary])
    |> validate_length(:name, min: 2, max: 20)
  end
end
