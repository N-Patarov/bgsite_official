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
    field :urls, :string
    timestamps()
  end

  @doc false
  def changeset(websites, attrs) do
    websites
    |> cast(attrs, [:title, :banner, :description, :likes, :urls])
    |> validate_required([:title, :description, :likes, :urls])
  end

  # def banner_changeset(website, attrs) do
  #  website
  #  |> cast(attrs, [])
  #  |> cast_attachments(attrs, [:banner])
  # end
end
