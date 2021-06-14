defmodule BgsiteOfficialWeb.WebsiteLive do
  use BgsiteOfficialWeb, :live_view

  alias BgsiteOfficial.Repo
  alias BgsiteOfficialWeb.WebsitesView
  alias BgsiteOfficial.Categories
  alias BgsiteOfficial.Home
  alias BgsiteOfficial.Accounts

  def render(assigns) do
   render WebsitesView, "show.html", assigns
  end

  @impl true
  def mount(params, %{"admin_token" => admin_token} = session, socket) do
    website = Home.get_website!(params["id"])
    tags = Categories.list_tags
    website_tags = Home.website_tags(website)
                   |>Enum.map(fn(x) -> x.tag_id end)

    admin = Accounts.get_admin_by_session_token(admin_token)
    socket = assign(
        socket,
        website: website,
        tags: tags,
        website_tags: website_tags,
        current_admin: admin
      )
    {:ok, socket}
  end

  def handle_event("toggle_check", %{"tag-id" => tag_id}, socket) do
    website = socket.assigns[:website]
              |> Repo.preload(:tags)
    Home.toggle_website_tag(website, tag_id)
    website_tags = Home.website_tags(website)
                   |>Enum.map(fn(x) -> x.tag_id end)
                   {:noreply, assign(socket, :website_tags, website_tags)}
  end
end
