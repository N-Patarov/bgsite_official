defmodule BgsiteOfficialWeb.FeedbackController do
  use BgsiteOfficialWeb, :controller

  alias BgsiteOfficial.Contacts
  alias BgsiteOfficial.Contacts.Feedback

  def index(conn, _params) do
    feedback = Contacts.list_feedback()
    render(conn, "index.html", feedback: feedback)
  end

  def new(conn, _params) do
    changeset = Contacts.change_feedback(%Feedback{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"feedback" => feedback_params}) do
    case Contacts.create_feedback(feedback_params) do
      {:ok, feedback} ->
        conn
        |> put_flash(:info, "Feedback created successfully.")
        |> redirect(to: Routes.feedback_path(conn, :show, feedback))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feedback = Contacts.get_feedback!(id)
    render(conn, "show.html", feedback: feedback)
  end

  def edit(conn, %{"id" => id}) do
    feedback = Contacts.get_feedback!(id)
    changeset = Contacts.change_feedback(feedback)
    render(conn, "edit.html", feedback: feedback, changeset: changeset)
  end

  def update(conn, %{"id" => id, "feedback" => feedback_params}) do
    feedback = Contacts.get_feedback!(id)

    case Contacts.update_feedback(feedback, feedback_params) do
      {:ok, feedback} ->
        conn
        |> put_flash(:info, "Feedback updated successfully.")
        |> redirect(to: Routes.feedback_path(conn, :show, feedback))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", feedback: feedback, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feedback = Contacts.get_feedback!(id)
    {:ok, _feedback} = Contacts.delete_feedback(feedback)

    conn
    |> put_flash(:info, "Feedback deleted successfully.")
    |> redirect(to: Routes.feedback_path(conn, :index))
  end
end
