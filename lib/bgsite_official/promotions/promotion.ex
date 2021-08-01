defmodule BgsiteOfficial.Promotions.Promotion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "promotions" do
    field :email, :string
    field :name, :string
    field :text, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(promotion, attrs) do
    promotion
    |> cast(attrs, [:url, :name, :email, :text])
    |> validate_required([:url, :name, :text])
  end
end
