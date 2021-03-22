defmodule BgsiteOfficial.Repo.Migrations.CreateFeedback do
  use Ecto.Migration

  def change do
    create table(:feedback) do
      add :name, :string
      add :email, :string
      add :text, :string

      timestamps()
    end

  end
end
