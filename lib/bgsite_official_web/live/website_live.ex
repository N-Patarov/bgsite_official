defmodule BgsiteOfficialWeb.WebsiteLive do
  use BgsiteOfficialWeb, :live_view

  alias BgsiteOfficialWeb.WebsitesView
  alias BgsiteOfficial.Categories
  alias BgsiteOfficial.Home
  alias BgsiteOfficial.Accounts

  def render(assigns) do
   render WebsitesView, "show.html", assigns
  end

  @impl true
  def mount(params, %{"admin_token" => admin_token} = session, socket) do
    website = Home.get_websites!(params["id"])
    tags = Categories.list_tags
    admin = Accounts.get_admin_by_session_token(admin_token)
    socket = assign(
        socket,
        websites: website,
        tags: tags,
        current_admin: admin
      )
    {:ok, socket}
  end

  def handle_event("toggle_check", %{"id" => id}, socket) do
    tag = Categories.get_tag!(id)
    Categories.update_tag(tag, %{check: !tag.check})
    {:noreply, socket}
  end
end
