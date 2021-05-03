defmodule BgsiteOfficial.Home.WebsiteTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias BgsiteOfficial.Home.Websites
  alias BgsiteOfficial.Categories.Tag

  schema "website_tag" do

    belongs_to :websites, Websites
    belongs_to :tag, Tag

    timestamps()
  end

  @doc false

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:websites_id, :tag_id])
    |> validate_required([:websites_id, :tag_id])
    # |> unique_constraint(:website_tag_unique, :website_tag_unique_index)
    # :website_tag_unique_index
  end
end
