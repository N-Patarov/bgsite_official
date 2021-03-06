defmodule BgsiteOfficial.Home.Websites do
  use Ecto.Schema
  import Ecto.Changeset
  use Waffle.Ecto.Schema

  @derive {Inspect, except: [:password]}
  schema "websites" do
    field :banner, Tutorial.AvatarUploader.Type
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

  def banner_changeset(website, attrs) do
   user
   |> cast(attrs, [])
   |> cast_attachments(attrs, [:banner])
  end
end
