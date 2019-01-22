defmodule Sky.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  alias Sky.Tags.Tag


  schema "tags" do
    field :name, :string
    field :sort, :string
    timestamps()
  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name, :sort])
    |> validate_required([:name, :sort])
    |> validate_exclusion(:name, ~w(admin superadmin 你大爷))
    |> validate_length(:name, min: 2, max: 3)
  end
end