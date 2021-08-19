defmodule BgsiteOfficial.Repo.Migrations.UserLike do
  use Ecto.Migration

  def change do
    create table(:user_like) do
      add(:user_id, references(:user))
      add(:website_id, references(:website))
      timestamps()
    end
    create unique_index(:user,[:user_id], name: :user_unique_index)
    create unique_index(:website,[:website_id], name: :website_unique_index)
  end
end
