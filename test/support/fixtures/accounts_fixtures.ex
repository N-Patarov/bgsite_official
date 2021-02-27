defmodule BgsiteOfficial.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BgsiteOfficial.Accounts` context.
  """

  def unique_admin_email, do: "admin#{System.unique_integer()}@example.com"
  def valid_admin_password, do: "hello world!"

  def admin_fixture(attrs \\ %{}) do
    {:ok, admin} =
      attrs
      |> Enum.into(%{
        email: unique_admin_email(),
        password: valid_admin_password()
      })
      |> BgsiteOfficial.Accounts.register_admin()

    admin
  end

  def extract_admin_token(fun) do
    {:ok, captured} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token, _] = String.split(captured.body, "[TOKEN]")
    token
  end
end
