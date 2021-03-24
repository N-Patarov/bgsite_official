defmodule BgsiteOfficial.Contacts.Feedback do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feedback" do
    field :email, :string
    field :name, :string
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(feedback, attrs) do
    feedback
    |> cast(attrs, [:name, :email, :text])
    |> validate_required([:name, :email, :text])
  end
end
