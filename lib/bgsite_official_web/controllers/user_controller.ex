defmodule  BgsiteOfficialWeb.UserController do
  use BgsiteOfficialWeb, :controller

  def index(conn, _params) do

    render(conn, "index.html")
  end

end
