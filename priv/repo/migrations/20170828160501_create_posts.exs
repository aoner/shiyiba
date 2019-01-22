defmodule Sky.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :name, :string
      add :introduction, :string
      add :body, :text
      add :read_volume, :integer
      add :author, :string
      add :source, :string

      timestamps()
    end

  end
end
