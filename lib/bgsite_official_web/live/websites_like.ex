defmodule BgsiteOfficialWeb.WebsitesLike do
  use BgsiteOfficialWeb, :live_view

  alias BgsiteOfficial.Repo
  alias BgsiteOfficialWeb.TagView
  alias BgsiteOfficial.Categories
  alias BgsiteOfficial.Accounts
  alias BgsiteOfficial.Categories.Tag
  alias BgsiteOfficial.Home.Websites
  alias BgsiteOfficial.Home.UserLike
  alias BgsiteOfficial.Home

  def render(assigns) do
    render TagView, "show.html", assigns
  end

  @impl true
  def mount(params, %{"user_token" => user_token} = session, socket) do
    tag = Categories.get_tag!(params["id"])
    websites = tag.websites |> Repo.preload(:tags)
    user = Accounts.get_user_by_session_token(user_token)
    user_like = Home.user_like(user)
                |>Enum.map(fn(x) -> x.websites_id end)
    socket = assign(
        socket,
        tag: tag,
        websites_for_tag: websites,
        website_likes_for: Map.new(websites, fn w -> {w.id, w.likes} end),
        current_user: user,
        user_like: user_like
      )
    # require IEx; IEx.pry
    {:ok, socket}
  end

  def handle_event("toggle_like", %{"website-id" => websites_id}, socket) do
    user = socket.assigns[:current_user]
         |> Repo.preload(:websites)
    Home.toggle_user_like(user, websites_id)
    user_like = Home.user_like(user)
                |>Enum.map(fn(x) -> x.websites_id end)

    updated_likes_count = Home.bump_likes(websites_id)
    current_likes_map = socket.assigns.website_likes_for
    updated_likes_map = %{current_likes_map | String.to_integer(websites_id) => updated_likes_count}

    socket = assign(socket, :website_likes_for, updated_likes_map)
    socket = assign(socket, :user_like, user_like)

    {:noreply, socket}

  end

  def handle_event("remove_like", %{"website-id" => websites_id}, socket) do
    user = socket.assigns[:current_user]
         |> Repo.preload(:websites)
    Home.toggle_user_like(user, websites_id)
    user_like = Home.user_like(user)
                |>Enum.map(fn(x) -> x.websites_id end)

    updated_likes_count = Home.remove_likes(websites_id)
    current_likes_map = socket.assigns.website_likes_for
    updated_likes_map = %{current_likes_map | String.to_integer(websites_id) => updated_likes_count}

    socket = assign(socket, :website_likes_for, updated_likes_map)
    socket = assign(socket, :user_like, user_like)

    {:noreply, socket}

  end


end
