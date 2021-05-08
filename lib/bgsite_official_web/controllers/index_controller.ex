defmodule  BgsiteOfficialWeb.IndexController do
  use BgsiteOfficialWeb, :controller

  alias BgsiteOfficial.Home
  alias BgsiteOfficial.Home.Websites
  alias BgsiteOfficial.Categories
  alias BgsiteOfficial.Categories.Tag

  def index(conn, _params) do
    websites = Home.list_websites(_params)
    tags = Categories.list_tags()
    render(conn, "index.html", websites: websites, tags: tags)
  end

end
