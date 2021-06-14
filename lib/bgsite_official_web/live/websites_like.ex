defmodule BgsiteOfficialWeb.WebsitesLike do
  use BgsiteOfficialWeb, :live_view

  alias BgsiteOfficial.Repo
  alias BgsiteOfficialWeb.TagView
  alias BgsiteOfficial.Categories
  alias BgsiteOfficial.Accounts
  alias BgsiteOfficial.Categories.Tag
  alias BgsiteOfficial.Home.Websites
  alias BgsiteOfficial.Home

  def render(assigns) do
    render TagView, "show.html", assigns
  end

  @impl true
  def mount(params, %{"admin_token" => admin_token} = session, socket) do
    tag = Categories.get_tag!(params["id"])
    websites = tag.websites |> Repo.preload(:tags)
    admin = Accounts.get_admin_by_session_token(admin_token)
    socket = assign(
        socket,
        tag: tag,
        websites_for_tag: websites,
        website_likes_for: Map.new(websites, fn w -> {w.id, w.likes} end),
        current_admin: admin
      )
    # require IEx; IEx.pry
    {:ok, socket}
  end

  def handle_event("addlike", %{"website-id" => website_id}, socket) do
    updated_likes_count = Home.bump_likes(website_id)
    current_likes_map = socket.assigns.website_likes_for
    updated_likes_map = %{current_likes_map | String.to_integer(website_id) => updated_likes_count}
    socket = assign(socket, :website_likes_for, updated_likes_map)
    {:noreply, socket}
  end


end
