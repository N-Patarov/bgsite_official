defmodule BgsiteOfficialWeb.TagLive do
  use BgsiteOfficialWeb, :live_view
  alias BgsiteOfficialWeb.TagView

  def render(assigns) do
    render TagView, "show.html", assigns
   end

end
