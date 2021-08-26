defmodule BgsiteOfficial.Repo.Migrations.RenameUserIdColumn do
  use Ecto.Migration

  def change do
    alter table("user_like") do
      remove(:user_id)
    end

    alter table("user_like") do
      add(:users_id, references(:users, on_delete: :delete_all))
    end

  end
end
