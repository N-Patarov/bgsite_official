defmodule BgsiteOfficial.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :title, :string
      add :banner, :string
      add :description, :string
      add :likes, :string

      timestamps()
    end

  end
end
