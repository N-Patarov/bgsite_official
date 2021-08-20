defmodule BgsiteOfficial.Home.UserLike do
  use Ecto.Schema
  import Ecto.Changeset
  alias BgsiteOfficial.Home.Websites
  alias BgsiteOfficial.Home.Users



  schema "user_like" do

    belongs_to :websites, Websites
    belongs_to :users, Users

    timestamps()
  end
end
