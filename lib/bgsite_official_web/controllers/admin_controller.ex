defmodule  BgsiteOfficialWeb.AdminController do
  use BgsiteOfficialWeb, :controller
  alias BgsiteOfficial.Requests
  alias BgsiteOfficial.Requests.Request
  alias BgsiteOfficial.Contacts
  alias BgsiteOfficial.Contacts.Feedback
  alias BgsiteOfficial.Categories
  alias BgsiteOfficial.Categories.Tag

  def index(conn, _params) do
    requests = Requests.list_requests()
    feedback = Contacts.list_feedback()
    tags = Categories.list_tags()
    render(conn, "index.html", requests: requests, feedback: feedback, tags: tags)
  end
end
