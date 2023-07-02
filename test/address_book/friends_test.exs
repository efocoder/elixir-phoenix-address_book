defmodule AddressBook.FriendsTest do
  use AddressBook.DataCase

  alias AddressBook.Friends

  describe "contacts" do
    alias AddressBook.Friends.Contact

    import AddressBook.FriendsFixtures

    @invalid_attrs %{age: nil, location: nil, name: nil, phone: nil, status: nil}

    test "list_contacts/0 returns all contacts" do
      contact = contact_fixture()
      assert Friends.list_contacts() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert Friends.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      valid_attrs = %{age: 42, location: "some location", name: "some name", phone: "some phone", status: "some status"}

      assert {:ok, %Contact{} = contact} = Friends.create_contact(valid_attrs)
      assert contact.age == 42
      assert contact.location == "some location"
      assert contact.name == "some name"
      assert contact.phone == "some phone"
      assert contact.status == "some status"
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Friends.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()
      update_attrs = %{age: 43, location: "some updated location", name: "some updated name", phone: "some updated phone", status: "some updated status"}

      assert {:ok, %Contact{} = contact} = Friends.update_contact(contact, update_attrs)
      assert contact.age == 43
      assert contact.location == "some updated location"
      assert contact.name == "some updated name"
      assert contact.phone == "some updated phone"
      assert contact.status == "some updated status"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()
      assert {:error, %Ecto.Changeset{}} = Friends.update_contact(contact, @invalid_attrs)
      assert contact == Friends.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = Friends.delete_contact(contact)
      assert_raise Ecto.NoResultsError, fn -> Friends.get_contact!(contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = Friends.change_contact(contact)
    end
  end
end
