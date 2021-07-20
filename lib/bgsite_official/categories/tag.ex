defmodule BgsiteOfficial.Categories.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias BgsiteOfficial.Home.Websites

  schema "tags" do
    field :banner, :string
    field :description, :string
    field :likes, :integer
    field :title, :string
    field :priority, :integer

    timestamps()

    many_to_many(
      :websites,
      Websites,
      join_through: "website_tag",
      on_replace: :delete
    )
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:title, :banner, :description, :likes,])
    |> validate_required([:title, :banner, :description])
  end
end
