defmodule BgsiteOfficial.Home.UserLike do
  use Ecto.Schema
  import Ecto.Changeset
  alias BgsiteOfficial.Home.Websites
  alias BgsiteOfficial.Accounts.User



  schema "user_like" do

    belongs_to :websites, Websites
    belongs_to :user, User

    timestamps()
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:websites_id, :user_id])
    |> validate_required([:websites_id, :user_id])
    # |> unique_constraint(:website_tag_unique, :website_tag_unique_index)
    # :website_tag_unique_index
  end

end
