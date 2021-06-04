defmodule BgsiteOfficial.Categories.TagPin do
  use Ecto.Schema
  import Ecto.Changeset
  alias BgsiteOfficial.Categories.Tag
  alias BgsiteOfficial.Accounts.User
  schema "tag_pin" do
    belongs_to :tag, Tag
    belongs_to :user, User
    timestamps()
  end
  @doc false
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:tag_id, :user_id])
    |> validate_required([:tag_id, :user_id])
  end
end
