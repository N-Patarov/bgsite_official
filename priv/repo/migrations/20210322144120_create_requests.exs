defmodule BgsiteOfficial.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :name, :string
      add :email, :email
      add :url, :string
      add :description, :string

      timestamps()
    end

  end
end
