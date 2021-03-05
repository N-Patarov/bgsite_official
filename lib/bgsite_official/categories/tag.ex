defmodule BgsiteOfficial.Categories.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :banner, :string
    field :description, :string
    field :likes, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:title, :banner, :description, :likes])
    |> validate_required([:title, :banner, :description, :likes])
  end
end
