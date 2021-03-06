defmodule BgsiteOfficial.Home.Websites do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias FileUploader.Storage.Picture

  schema "websites" do
    field :banner, :string
    field :description, :string
    field :likes, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(websites, attrs) do
    websites
    |> cast(attrs, [:title, :banner, :description, :likes])
    |> validate_required([:title, :banner, :description, :likes])
  end
end
