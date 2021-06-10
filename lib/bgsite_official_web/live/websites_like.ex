defmodule BgsiteOfficialWeb.WebsitesLike do
  use BgsiteOfficialWeb, :live_view

  alias BgsiteOfficial.Repo
  alias BgsiteOfficialWeb.TagView
  alias BgsiteOfficial.Categories
  alias BgsiteOfficial.Accounts
  alias BgsiteOfficial.Categories.Tag
  alias BgsiteOfficial.Home.Websites

  def render(assigns) do
    render TagView, "show.html", assigns
  end

  @impl true
  def mount(params, %{"admin_token" => admin_token} = session, socket) do
    tag = Categories.get_tag!(params["id"])
    website = tag.websites |> Repo.preload(:tags)
    admin = Accounts.get_admin_by_session_token(admin_token)
    socket = assign(
        socket,
        tag: tag,
        websites_for_tag: website,
        current_admin: admin
      )
    {:ok, socket}
  end

  def handle_event("add_like", %{"website-id" => website_id}, socket) do
     website = Home.get_websites!(website_id)
     current_likes_count = website.likes
     updated_likes_count = current_likes_count + 1
     Home.bump_likes(website, %{likes: updated_likes_count})
     {:noreply, socket}
   end


end
