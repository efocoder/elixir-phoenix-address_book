defmodule AddressBook.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AddressBook.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        email: "some email",
        nickname: "some nickname",
        password: "some password"
      })
      |> AddressBook.Accounts.create_account()

    account
  end
end
