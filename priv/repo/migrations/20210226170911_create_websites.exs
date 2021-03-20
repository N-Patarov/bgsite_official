defmodule BgsiteOfficial.Repo.Migrations.CreateWebsites do
  use Ecto.Migration

  def change do
    create table(:websites) do
      add :title, :string
      add :banner, :string
      add :description, :string
      add :likes, :integer
      add :url, :string

      timestamps()
    end

  end
end
