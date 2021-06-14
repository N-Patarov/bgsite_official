defmodule BgsiteOfficialWeb.WebsitesController do
  use BgsiteOfficialWeb, :controller

  alias BgsiteOfficial.Home
  alias BgsiteOfficial.Home.Websites
  alias BgsiteOfficial.Categories
  alias BgsiteOfficial.Categories.Tags

  def index(conn, params) do
    websites = Home.list_websites(params)
    tags = Categories.list_tags()
    render(conn, "index.html", websites: websites, tags: tags)
  end

  def new(conn, _params) do
    changeset = Home.change_websites(%Websites{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"websites" => websites_params}) do
    case Home.create_websites(websites_params) do
      {:ok, websites} ->
        conn
        |> put_flash(:info, "Websites created successfully.")
        |> redirect(to: Routes.websites_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    website = Home.get_website!(id)
    tags = Categories.list_tags()
    render(conn, "show_conn.html", website: website, website_tags: website.tags, tags: tags)
  end

  def edit(conn, %{"id" => id}) do
    websites = Home.get_website!(id)
    changeset = Home.change_websites(websites)
    render(conn, "edit.html", websites: websites, changeset: changeset)
  end

  def update(conn, %{"id" => id, "websites" => websites_params}) do
    websites = Home.get_website!(id)

    case Home.update_website(websites, websites_params) do
      {:ok, websites} ->
        conn
        |> put_flash(:info, "Websites updated successfully.")
        |> redirect(to: Routes.websites_path(conn, :show, websites))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", websites: websites, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    websites = Home.get_website!(id)
    {:ok, _websites} = Home.delete_websites(websites)

    conn
    |> put_flash(:info, "Websites deleted successfully.")
    |> redirect(to: Routes.websites_path(conn, :index))
  end

  # S3

  # def update_banner(conn, %{"websites" => websites_params}) do
  #   websites = conn.assigns.current_websites
  #
  #   case Accounts.update_websites_banner(websites, websites_params) do
  #     {:ok, websites} ->
  #       conn
  #       |> put_flash(:info, "banner updated successfully.")
  #       |> redirect(to: Routes.websites_settings_path(conn, :edit))
  #
  #   {:error, changeset} ->
  #     render(conn, "edit.html", banner_changeset: changeset)
  #   end
  # end

  # defp assign_email_and_password_changesets(conn, _opts) do
  #   websites = conn.assigns.current_websites
  #
  #   conn
  #   |> assign(:banner_changeset, Accounts.change_websites_banner(websites))
  #   |> assign(:websites, websites)
  #
  # end

end
