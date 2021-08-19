defmodule BgsiteOfficial.Repo.Migrations.UserLike do
  use Ecto.Migration

  def change do
    create table(:user_like) do
      add(:user_id, references(:users, on_delete: :delete_all))
      add(:website_id, references(:websites, on_delete: :delete_all))
      timestamps()
    end

    create unique_index(:user_like, [:user_id, :website_id], name: :user_like_unique_index)

  end
end
