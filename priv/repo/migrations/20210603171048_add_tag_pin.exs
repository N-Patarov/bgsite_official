defmodule BgsiteOfficial.Repo.Migrations.AddTagPin do
  use Ecto.Migration

  def change do
    create table(:tag_pin) do
      add(:tag_id, references(:tags, on_delete: :delete_all))
      add(:user_id, references(:users, on_delete: :delete_all))
      timestamps()
    end
    create unique_index(:tag_pin, [:user_id, :tag_id], name: :tag_pin_unique_index)
  end
end
