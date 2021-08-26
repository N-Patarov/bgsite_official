defmodule BgsiteOfficial.Repo.Migrations.AddUserIdToUserLike do
  use Ecto.Migration

  def change do
    alter table("user_like") do
      add(:user_id, references(:users, on_delete: :delete_all))
    end

  end
end
