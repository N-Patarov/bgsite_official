defmodule BgsiteOfficial.Home do
  @moduledoc """
  The Home context.
  """

  import Ecto.Query, warn: false
  alias BgsiteOfficial.Repo

  alias BgsiteOfficial.Home.Websites
  alias BgsiteOfficial.Home.WebsiteTag
  alias BgsiteOfficial.Categories.Tag

  def toggle_website_tag(%Websites{} = website, tag_id) do
    ww = website.id
    query = from(wt in WebsiteTag, where: wt.websites_id == ^ww and wt.tag_id == ^tag_id)
    assoc = Repo.one(query)
    # require IEx; IEx.pry
    if assoc == nil do
      %WebsiteTag{}
      |> WebsiteTag.changeset(%{websites_id: website.id, tag_id: tag_id})
      |> Repo.insert()
    else
      Repo.delete(assoc)
    end
  end

  def bump_site_likes(%Websites{} = website, likes) do
    website = website.id
    query = from(w in Websites, where: w.websites_id == ^website)
    assoc = Repo.one(query)
    if assoc == nil do
      %Websites{}
      |> Websites.changeset(%{website_id: website.id, likes: likes})
      |> Repo.insert()
    end
  end

  @doc """
  Returns the list of websites.

  ## Examples

      iex> list_websites()
      [%Websites{}, ...]

  """

  # def update_websites_banner(%Website{} = website, attrs) do
  #   user
  #   |> Website.banner_changeset(attrs)
  #   |> Repo.update()
  # end
  #
  # def change_websites_banner(%Website{} = website) do
  #   Website.banner_changeset(user, %{})
  # end

  # def website_with_tag?(%Websites = website, tag_id) do
  #
  # end
  def website_tags(%Websites{} = website) do
    website_id = website.id
    query_join_table = from(wt in WebsiteTag, where: wt.websites_id == ^website_id)
    Repo.all(query_join_table)
  end

  def list_websites(params = %{"query" => search_term}) do
    Websites
    |>Websites.search(search_term)
    |>Repo.all()
  end

  def list_websites(_params) do
    Repo.all(Websites)
  end
  @spec get_websites!(any) :: nil | [%{optional(atom) => any}] | %{optional(atom) => any}
  @doc """
  Gets a single websites.

  Raises `Ecto.NoResultsError` if the Websites does not exist.

  ## Examples

      iex> get_websites!(123)
      %Websites{}

      iex> get_websites!(456)
      ** (Ecto.NoResultsError)

  """
  def get_websites!(id) do
    Repo.get!(Websites, id)
    |> Repo.preload(:tags)
  end

  @doc """
  Creates a websites.

  ## Examples

      iex> create_websites(%{field: value})
      {:ok, %Websites{}}

      iex> create_websites(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_websites(attrs \\ %{}) do
    %Websites{}
    |> Websites.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a websites.

  ## Examples

      iex> update_websites(websites, %{field: new_value})
      {:ok, %Websites{}}

      iex> update_websites(websites, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_websites(%Websites{} = websites, attrs) do
    websites
    |> Websites.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a websites.

  ## Examples

      iex> delete_websites(websites)
      {:ok, %Websites{}}

      iex> delete_websites(websites)
      {:error, %Ecto.Changeset{}}

  """
  def delete_websites(%Websites{} = websites) do
    Repo.delete(websites)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking websites changes.

  ## Examples

      iex> change_websites(websites)
      %Ecto.Changeset{data: %Websites{}}

  """
  def change_websites(%Websites{} = websites, attrs \\ %{}) do
    Websites.changeset(websites, attrs)
  end
end
