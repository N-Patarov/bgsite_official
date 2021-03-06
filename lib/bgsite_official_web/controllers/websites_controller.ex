defmodule BgsiteOfficialWeb.WebsitesController do
  use BgsiteOfficialWeb, :controller

  alias BgsiteOfficial.Home
  alias BgsiteOfficial.Home.Websites

  def index(conn, _params) do
    websites = Home.list_websites()
    render(conn, "index.html", websites: websites)
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
        |> redirect(to: Routes.websites_path(conn, :show, websites))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    websites = Home.get_websites!(id)
    render(conn, "show.html", websites: websites)
  end

  def edit(conn, %{"id" => id}) do
    websites = Home.get_websites!(id)
    changeset = Home.change_websites(websites)
    render(conn, "edit.html", websites: websites, changeset: changeset)
  end

  def update(conn, %{"id" => id, "websites" => websites_params}) do
    websites = Home.get_websites!(id)

    case Home.update_websites(websites, websites_params) do
      {:ok, websites} ->
        conn
        |> put_flash(:info, "Websites updated successfully.")
        |> redirect(to: Routes.websites_path(conn, :show, websites))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", websites: websites, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    websites = Home.get_websites!(id)
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
