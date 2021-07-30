defmodule BgsiteOfficial.Repo.Migrations.CreatePromotions do
  use Ecto.Migration

  def change do
    create table(:promotions) do
      add :url, :string
      add :name, :string
      add :email, :string
      add :text, :string

      timestamps()
    end

  end
end
