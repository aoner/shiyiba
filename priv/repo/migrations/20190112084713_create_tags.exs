defmodule Sky.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string
      add :sort, :string
      timestamps()
    end

  end
end
