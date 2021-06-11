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

  def handle_event("addlike", %{"website-id" => website_id}, socket) do
     Home.bump_likes(website_id)
     {:noreply, socket}
   end


end
