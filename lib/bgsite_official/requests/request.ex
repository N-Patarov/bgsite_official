defmodule BgsiteOfficial.Requests.Request do
  use Ecto.Schema
  import Ecto.Changeset

  schema "requests" do
    field :description, :string
    field :email, :string
    field :name, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, [:name, :email, :url, :description])
    |> validate_required([:name, :email, :url, :description])
  end
end
