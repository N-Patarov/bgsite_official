defmodule BgsiteOfficial.Repo.Migrations.AddWebsiteTagTable do
  use Ecto.Migration

  def change do

    create table(:website_tag, primary_key: false) do
      add(:website_id, references(:websites, on_delete: :delete_all), primary_key: true)
      add(:tag_id, references(:tags, on_delete: :delete_all), primary_key: true)
      timestamps()
    end
    create(index(:website_tag, [:website_id]))
    create(index(:website_tag, [:tag_id]))
  end
end
