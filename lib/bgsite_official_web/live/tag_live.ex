defmodule BgsiteOfficialWeb.TagLive do
  use BgsiteOfficialWeb, :live_view

  alias BgsiteOfficial.Repo
  alias BgsiteOfficialWeb.TagView
  alias BgsiteOfficial.Categories
  alias BgsiteOfficial.Accounts
  alias BgsiteOfficial.Categories.Tag

  def render(assigns) do
    render TagView, "show.html", assigns

   end
     @impl true
  def mount(params, %{"admin_token" => admin_token} = session, socket) do
    tag = Categories.get_tag!(params["id"])
    websites = tag.websites |> Repo.preload(:tags)
    admin = Accounts.get_admin_by_session_token(admin_token)
    socket = assign(socket,:likes,0)
    socket = assign(
        socket,
        tag: tag,
        websites_for_tag: websites,
        current_admin: admin
      )
    {:ok, socket}
  end

  def handle_event("like",_,socket)do
    socket=update(socket,:likes, &(&1+1))
    {:noreply,socket}


  end

end
