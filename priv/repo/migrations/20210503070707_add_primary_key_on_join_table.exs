defmodule BgsiteOfficial.Repo.Migrations.AddPrimaryKeyOnJoinTable do
  use Ecto.Migration

  def change do
    alter table("website_tag") do
      remove(:websites_id)
      remove(:tag_id)
    end

    alter table("website_tag") do
      add(:websites_id, references(:websites, on_delete: :delete_all))
      add(:tag_id, references(:tags, on_delete: :delete_all))
      add(:id, :bigserial, primary_key: true)
    end

    create unique_index(:website_tag, [:websites_id, :tag_id], name: :website_tag_unique_index)
  end
end
