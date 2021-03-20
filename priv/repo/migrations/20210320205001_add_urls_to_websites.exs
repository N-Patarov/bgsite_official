defmodule BgsiteOfficial.Repo.Migrations.AddUrlsToWebsites do
  use Ecto.Migration

  def change do
    alter table("websites") do
      add :urls, :string
    end
  end
end
