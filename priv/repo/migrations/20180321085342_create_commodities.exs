defmodule Sky.Repo.Migrations.CreateCommodities do
  use Ecto.Migration

  def change do
    create table(:commodities) do
      add :user_id, references(:users, on_delete: :nothing)
      add :name, :string
      add :icon, :string
      add :price, :decimal
      add :count, :integer
      add :summary, :text

      timestamps()
    end

    create index(:commodities, [:user_id])
  end
end
