defmodule  BgsiteOfficialWeb.AdminController do
  use BgsiteOfficialWeb, :controller
  alias BgsiteOfficial.Requests
  alias BgsiteOfficial.Requests.Request
  
  def index(conn, _params) do
    requests = Requests.list_requests()
    render(conn, "index.html", requests: requests)
  end
end
