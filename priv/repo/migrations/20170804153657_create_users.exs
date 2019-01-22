defmodule Sky.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :mobile, :string
      add :password_digest, :string
      add :name, :string
      add :avatar, :string
      add :age, :integer
      add :sex, :string
      add :province, :string
      add :city, :string
      add :address, :string

      timestamps()
    end

    create unique_index(:users, [:mobile])
  end
end
