defmodule BgsiteOfficial.Home.Websites do
  use Ecto.Schema
  import Ecto.Changeset
  use Waffle.Ecto.Schema
  import Ecto.Query, only: [from: 2]

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
  def search(query, search_term)do
    wildcard_search = "%#{search_term}"

    from websites in query,
    where: ilike(websites.title,^wildcard_search)
  end
end
