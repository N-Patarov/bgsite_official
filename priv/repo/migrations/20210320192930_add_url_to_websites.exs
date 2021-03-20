defmodule BgsiteOfficial.Repo.Migrations.AddUrlToWebsites do
  use Ecto.Migration

  def change do
    alter table(:websites) do
      add :url, :string
    end
  end
end
