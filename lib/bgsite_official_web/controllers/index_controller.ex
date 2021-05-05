defmodule  BgsiteOfficialWeb.IndexController do
  use BgsiteOfficialWeb, :controller

  alias BgsiteOfficial.Home
  alias BgsiteOfficial.Home.Websites
  def index(conn, _params) do
    websites = Home.list_websites(_params)
    render(conn, "index.html", websites: websites)
  end

end
