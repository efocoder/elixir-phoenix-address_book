defmodule AddressBook.FriendsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AddressBook.Friends` context.
  """

  @doc """
  Generate a contact.
  """
  def contact_fixture(attrs \\ %{}) do
    {:ok, contact} =
      attrs
      |> Enum.into(%{
        age: 42,
        location: "some location",
        name: "some name",
        phone: "some phone",
        status: "some status"
      })
      |> AddressBook.Friends.create_contact()

    contact
  end
end
