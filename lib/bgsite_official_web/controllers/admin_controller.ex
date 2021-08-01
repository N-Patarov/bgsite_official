defmodule  BgsiteOfficialWeb.AdminController do
  use BgsiteOfficialWeb, :controller
  alias BgsiteOfficial.Requests
  alias BgsiteOfficial.Requests.Request
  alias BgsiteOfficial.Contacts
  alias BgsiteOfficial.Contacts.Feedback
  alias BgsiteOfficial.Categories
  alias BgsiteOfficial.Categories.Tag
  alias BgsiteOfficial.Home
  alias BgsiteOfficial.Home.Websites
  alias BgsiteOfficial.Promotions
  alias BgsiteOfficial.Promotions.Promotion

  def index(conn, params) do
    websites = Home.list_websites(params)
    requests = Requests.list_requests()
    feedback = Contacts.list_feedback()
    promotions = Promotions.list_promotions()
    tags = Categories.list_tags()
    render(conn, "index.html", requests: requests, feedback: feedback, tags: tags, websites: websites, promotions: promotions)
  end

  def websites(conn, params) do
    websites = Home.list_websites(params)
    render(conn, "websites.html", websites: websites)
  end
end
