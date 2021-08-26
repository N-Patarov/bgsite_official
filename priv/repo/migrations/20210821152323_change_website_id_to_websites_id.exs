defmodule BgsiteOfficial.Repo.Migrations.ChangeWebsiteIdToWebsitesId do
  use Ecto.Migration

  def change do
    alter table("user_like") do
      remove(:website_id)
    end

    alter table("user_like") do
      add(:websites_id, references(:websites, on_delete: :delete_all))
    end

  end
end
