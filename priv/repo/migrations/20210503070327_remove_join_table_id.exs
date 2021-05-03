defmodule BgsiteOfficial.Repo.Migrations.RemoveJoinTableId do
  use Ecto.Migration

  def change do
    alter table("website_tag") do
      remove :id
    end
  end
end
