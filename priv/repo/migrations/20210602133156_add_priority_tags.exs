defmodule BgsiteOfficial.Repo.Migrations.AddPriorityTags do
  use Ecto.Migration

  def change do
    alter table("tags") do
      add :priority, :integer
    end
  end  
end
