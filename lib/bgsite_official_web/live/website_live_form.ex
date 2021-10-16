defmodule BgsiteOfficialWeb.WebsiteLiveForm do
  use BgsiteOfficialWeb, :live_view

  alias BgsiteOfficial.Repo
  alias BgsiteOfficialWeb.WebsitesView
  alias BgsiteOfficial.Categories
  alias BgsiteOfficial.Home
  alias BgsiteOfficial.Accounts
  alias BgsiteOfficial.Home.Websites

  def render(assigns) do
   render WebsitesView, "live_form.html", assigns
  end

  @impl true
  def mount(params, %{"admin_token" => admin_token} = session, socket) do
    admin = Accounts.get_admin_by_session_token(admin_token)
    socket = assign(
        socket,
        current_admin: admin
      )
    {:ok, socket}
  end

  def handle_event("create_website", %{
                                      "website" => %{
                                        "website_description" => description,
                                        "website_likes" => likes,
                                        "website_priority" => priority,
                                        "website_title" => title,
                                        "website_url" => url
                                      }
                                    }, socket) do


    Home.live_create_website(title, description, likes, url, priority)

    {:noreply, socket}
  end

end
