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

  # def changeset_update_projects(%Tag{} = tags, attrs) do
  #     website
  #     |> cast(%{}, @required_fields)
  #     # associate projects to the user
  #     |> put_assoc(:websites, websites)
  # end

  # many_to_many
  # (
  #     :websites,
  #     Website,
  #     join_through: "website_project",
  #     on_replace: :delete
  # )

end
