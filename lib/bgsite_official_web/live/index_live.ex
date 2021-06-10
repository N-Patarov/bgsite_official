defmodule BgsiteOfficialWeb.IndexLive do
  use BgsiteOfficialWeb, :live_view

  alias BgsiteOfficial.Repo
  alias BgsiteOfficialWeb.WebsitesView
  alias BgsiteOfficial.Categories
  alias BgsiteOfficial.Home
  alias BgsiteOfficial.Accounts
  alias BgsiteOfficial.Home.Websites

  def render(assigns) do
   render WebsitesView, "index.html", assigns
  end

  @impl true

def mount(params, %{"user_token" => user_token} = session, socket) do
  website = Home.get_websites!(params["id"])
  tags = Categories.list_tags
  website_tags = Home.website_tags(website)
                 |>Enum.map(fn(x) -> x.tag_id end)
  user = Accounts.get_user_by_session_token(user_token)
  socket = assign(
      socket,
      website: website,
      tags: tags,
      website_tags: website_tags,
      current_user: user
    )
  {:ok, socket}
end

def handle_event("toggle_pin", %{"tag-id" => tag_id}, socket) do
  user = socket.assigns[:current_user]
            |> Repo.preload(:tags)
  Home.toggle_tag_pin(user, tag_id)
  tag_pin = Home.tag_pin(user)
                 |>Enum.map(fn(x) -> x.tag_id end)
                 {:noreply, assign(socket, :tag_pin, tag_pin)}
end

end
