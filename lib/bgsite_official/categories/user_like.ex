defmodule BgsiteOfficial.Categories.UserLike do
  use Ecto.Schema
  import Ecto.Changeset
  alias BgsiteOfficial.Home.Websites
  alias BgsiteOfficial.Home.Users



  schema "user_like" do

    many_to_many(
      :websites,
      Websites,
      join_through: "user_like",
      on_replace: :delete
    )
  end
end
