defmodule BgsiteOfficial.Repo.Migrations.AddIdToWebsiteTag do
  use Ecto.Migration

  def change do
    alter table("website_tag") do
      add :id, :integer
    end
  end
end
