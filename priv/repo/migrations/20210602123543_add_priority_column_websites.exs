defmodule BgsiteOfficial.Repo.Migrations.AddPriorityColumnWebsites do
  use Ecto.Migration

  def change do
    alter table("websites") do
      add :priority, :integer
    end
  end
end
