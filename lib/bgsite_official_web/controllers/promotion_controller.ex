defmodule BgsiteOfficialWeb.PromotionController do
  use BgsiteOfficialWeb, :controller

  alias BgsiteOfficial.Promotions
  alias BgsiteOfficial.Promotions.Promotion

  def index(conn, _params) do
    promotions = Promotions.list_promotions()
    render(conn, "index.html", promotions: promotions)
  end

  def new(conn, _params) do
    changeset = Promotions.change_promotion(%Promotion{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"promotion" => promotion_params}) do
    %Plug.Conn{assigns: %{current_user: current_user}} = conn
    promotion_params_with_email = Map.merge(promotion_params, %{"email" => current_user.email})
    case Promotions.create_promotion(promotion_params) do
      {:ok, promotion} ->
        conn
        |> put_flash(:info, "Благодарим Ви за заявката! Екипът на izberi.site ще се свърже с вас възможно най-скоро!")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    promotion = Promotions.get_promotion!(id)
    render(conn, "show.html", promotion: promotion)
  end

  def edit(conn, %{"id" => id}) do
    promotion = Promotions.get_promotion!(id)
    changeset = Promotions.change_promotion(promotion)
    render(conn, "edit.html", promotion: promotion, changeset: changeset)
  end

  def update(conn, %{"id" => id, "promotion" => promotion_params}) do
    promotion = Promotions.get_promotion!(id)

    case Promotions.update_promotion(promotion, promotion_params) do
      {:ok, promotion} ->
        conn
        |> put_flash(:info, "Promotion updated successfully.")
        |> redirect(to: Routes.promotion_path(conn, :show, promotion))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", promotion: promotion, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    promotion = Promotions.get_promotion!(id)
    {:ok, _promotion} = Promotions.delete_promotion(promotion)

    conn
    |> put_flash(:info, "Promotion deleted successfully.")
    |> redirect(to: Routes.promotion_path(conn, :index))
  end
end
