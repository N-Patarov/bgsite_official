defmodule BgsiteOfficialWeb.WebsiteLive do
  use BgsiteOfficialWeb, :live_view
  require IEx

  alias BgsiteOfficialWeb.WebsitesView
  alias BgsiteOfficial.Categories
  alias BgsiteOfficial.Home
  alias BgsiteOfficial.Accounts

  def render(assigns) do
   render WebsitesView, "show.html", assigns
  end

  @impl true
  # def mount(params, %{"admin_id" => admin_id} = session, socket) do
  def mount(params, session, socket) do
    %{"admin_token" => admin_token} = session
    website = Home.get_websites!(params["id"])
    tags = Categories.list_tags
    admin = Accounts.get_admin_by_session_token(admin_token)
    socket = assign(
        socket,
        websites: website,
        tags: tags,
      current_admin: admin,
      # conn: conn
      )
    {:ok, socket}
  end
end
