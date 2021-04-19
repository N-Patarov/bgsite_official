defmodule BgsiteOfficial.Websites.TagsInWebsites do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags_in_websites" do

    field :website_id, :decimal
    field :tag_id, :decimal

    timestamps()
  end
  @doc false

  def changeset(tags_in_websites, attrs) do
    tag
    |> cast(attrs, [:title, :description])
    |> validate_required([:title])
    |> cast(params, [:website_id, :tag_id])
    |> validate_required([:website_id, :tag_id])
  end
end
