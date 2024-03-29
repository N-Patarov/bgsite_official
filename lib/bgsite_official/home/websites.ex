defmodule BgsiteOfficial.Home.Websites do
  use Ecto.Schema
  import Ecto.Changeset
  use Waffle.Ecto.Schema
  import Ecto.Query, only: [from: 2]
  alias BgsiteOfficial.Categories.Tag
  alias BgsiteOfficial.Home.Websites
  alias BgsiteOfficial.Accounts.User

  # @derive {Inspect, except: [:password]}
  schema "websites" do
    field :banner, BgsiteOfficial.BannerUploader.Type
    field :description, :string
    field :title, :string
    field :likes, :integer
    field :priority, :integer
    field :urls, :string
    timestamps()

    many_to_many(
      :tags,
      Tag,
      join_through: "website_tag",
      on_replace: :delete
    )
    many_to_many(
      :users,
      User,
      join_through: "user_like",
      on_replace: :delete
    )
  end

  def changeset(websites, attrs) do
    websites
    |> cast(attrs, [:title, :banner, :description, :priority, :likes, :urls])
    |> validate_required([:title, :description, :priority, :likes, :urls])
  end

  # def banner_changeset(website, attrs) do
  #  website
  #  |> cast(attrs, [])
  #  |> cast_attachments(attrs, [:banner])
  # end
  # def search(query, search_term) do
  #   wildcard_search = "%#{search_term}"
  #
  #   from websites in query,
  #   where: fragment("SIMILARITY(?, ?) > 0.4",  websites.title, ^wildcard_search),
  #   order_by: fragment("LEVENSHTEIN(?, ?)", websites.title, ^wildcard_search),
  #   or_where: fragment("SIMILARITY(?, ?) > 0.4",  websites.description, ^wildcard_search),
  #   order_by: fragment("LEVENSHTEIN(?, ?)", websites.description, ^wildcard_search)
  # end

  def search(query, search_term) do
    wildcard_search = "%#{search_term}%"

    from websites in query,
    where: ilike(websites.title, ^wildcard_search),
    or_where: ilike(websites.description, ^wildcard_search)
  end
end
