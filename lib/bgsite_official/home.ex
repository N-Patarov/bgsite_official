defmodule BgsiteOfficial.Home do
  @moduledoc """
  The Home context.
  """

  import Ecto.Query, warn: false
  alias BgsiteOfficial.Repo
  alias BgsiteOfficial.Home
  alias BgsiteOfficial.Home.Websites
  alias BgsiteOfficial.Home.WebsiteTag
  alias BgsiteOfficial.Home.UserLike
  alias BgsiteOfficial.Categories.Tag
  alias BgsiteOfficial.Accounts.User

  # Website_Tags Many_to_Many

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

  def website_tags(%Websites{} = website) do
    website_id = website.id
    query_join_table = from(wt in WebsiteTag, where: wt.website_id == ^website_id)
    Repo.all(query_join_table)
  end

  # -- End -- Website_Tags Many_to_Many

  # User_Like (user_websites) Many_to_Many


  def toggle_user_like(%User{} = user, websites_id) do
    uu = user.id
    query = from(ul in UserLike, where: ul.user_id == ^uu and ul.websites_id == ^websites_id)
    assoc = Repo.one(query)
    # require IEx; IEx.pry
    if assoc == nil do
      %UserLike{}
      |> UserLike.changeset(%{websites_id: websites_id, user_id: user.id})
      |> Repo.insert()
    else
      Repo.delete(assoc)
    end
  end

  def user_like(%User{} = user) do
    user_id = user.id
    query_join_table = from(ul in UserLike, where: ul.user_id == ^user_id)
    Repo.all(query_join_table)
  end

  def bump_likes(websites_id) do
    website = Home.get_website!(websites_id)
    updated_likes_count = website.likes + 1
    update_website(website, %{likes: updated_likes_count})
    updated_likes_count
  end

  def remove_likes(websites_id) do
    website = Home.get_website!(websites_id)
    updated_likes_count = website.likes - 1
    update_website(website, %{likes: updated_likes_count})
    updated_likes_count
  end

  # -- End -- User_Like (user_websites) Many_to_Many



  def list_websites(params = %{"query" => search_term}) do
    Websites
    |>Websites.search(search_term)
    |>Repo.all()
  end

  def list_websites(_params) do
    filter = from(w in Websites, order_by: [desc: w.priority])
    Repo.all(filter)
  end

  def list_websites_top3(_params) do
    filter = from(w in Websites, order_by: [desc: w.likes])
    Repo.all(filter) |> Enum.take(3)
  end


  @spec get_website!(any) :: nil | [%{optional(atom) => any}] | %{optional(atom) => any}

  def get_website!(id) do
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
  def update_website(%Websites{} = website, attrs) do
    website
    |> Websites.changeset(attrs)
    |> IO.inspect(label: "update website")
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
