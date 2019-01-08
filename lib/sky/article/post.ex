defmodule Sky.Article.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Sky.Article.Post


  schema "posts" do
    field :body, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:name, :body])
    |> validate_required([:name, :body])
  end
end
