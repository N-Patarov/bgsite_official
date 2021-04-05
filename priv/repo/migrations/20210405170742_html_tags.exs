defmodule BgsiteOfficial.Repo.Migrations.HtmlTags do
  use Ecto.Migration

  def change do
    alter table(:websites) do
      add :tag, :string
    end
  end
end
