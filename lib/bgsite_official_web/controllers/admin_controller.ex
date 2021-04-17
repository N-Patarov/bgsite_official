defmodule  BgsiteOfficialWeb.AdminController do
  use BgsiteOfficialWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
