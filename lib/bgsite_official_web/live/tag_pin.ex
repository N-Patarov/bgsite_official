defmodule BgsiteOfficialWeb.TagPin do
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
  def mount(conn, params, socket) do
    websites = Home.list_websites(params)
    tags = Categories.list_tags()

    socket = assign(
        socket,
        conn,
        websites: websites,
        tags: tags,
      )
    {:ok, socket}
  end

end
