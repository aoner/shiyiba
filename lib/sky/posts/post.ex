defmodule Sky.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Sky.Posts.Post


  schema "posts" do
    field :body, :string
    field :name, :string
    field :introduction, :string
    field :author, :string
    field :source, :string
    field :read_volume, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:name, :introduction, :body, :author, :source])
    |> validate_required([:name, :introduction, :body, :author, :source])
  end
end
