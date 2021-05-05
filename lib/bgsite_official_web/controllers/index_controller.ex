defmodule  BgsiteOfficialWeb.IndexController do
  use BgsiteOfficialWeb, :controller

  alias BgsiteOfficial.Websites

  def index(conn, _params) do
    render(conn, "index.html")

  end

end
