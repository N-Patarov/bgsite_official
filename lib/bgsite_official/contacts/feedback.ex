defmodule BgsiteOfficial.Contacts.Feedback do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feedback" do
    field :emai, :string
    field :name, :string
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(feedback, attrs) do
    feedback
    |> cast(attrs, [:name, :emai, :text])
    |> validate_required([:name, :emai, :text])
  end
end
