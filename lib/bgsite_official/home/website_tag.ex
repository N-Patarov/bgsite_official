defmodule BgsiteOfficial.Websites.WebsiteTag do 
  use Ecto.Schema
  import Ecto.Changeset

  schema "website_tag" do

    field :website_id, :decimal
    field :tag_id, :decimal

    timestamps()
  end
  @doc false

  def changeset(website_tag, attrs) do
    @tag
    |> cast(attrs, [:website_id, :tag_id])
    |> validate_required([:website_id, :tag_id])
  end
end
