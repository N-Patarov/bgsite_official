defmodule BgsiteOfficial.Home.Websites do
  use Ecto.Schema
  import Ecto.Changeset
  use Waffle.Ecto.Schema

  @derive {Inspect, except: [:password]}
  schema "websites" do
    field :banner, BgsiteOfficial.BannerUploader.Type
    field :description, :string
    field :likes, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(websites, attrs) do
    websites
    |> cast(attrs, [:title, :banner, :description, :likes])
    |> validate_required([:title, :description, :likes])
  end

  # def banner_changeset(website, attrs) do
  #  website
  #  |> cast(attrs, [])
  #  |> cast_attachments(attrs, [:banner])
  # end

  

  many_to_many
  (
      :tags,
      Tag,
      join_through: "tag_project",
      on_replace: :delete
  )


end
