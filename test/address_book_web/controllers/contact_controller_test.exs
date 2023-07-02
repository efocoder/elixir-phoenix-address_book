defmodule AddressBookWeb.ContactControllerTest do
  use AddressBookWeb.ConnCase

  import AddressBook.FriendsFixtures

  alias AddressBook.Friends.Contact

  @create_attrs %{
    age: 42,
    location: "some location",
    name: "some name",
    phone: "some phone",
    status: "some status"
  }
  @update_attrs %{
    age: 43,
    location: "some updated location",
    name: "some updated name",
    phone: "some updated phone",
    status: "some updated status"
  }
  @invalid_attrs %{age: nil, location: nil, name: nil, phone: nil, status: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all contacts", %{conn: conn} do
      conn = get(conn, ~p"/api/contacts")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create contact" do
    test "renders contact when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/contacts", contact: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/contacts/#{id}")

      assert %{
               "id" => ^id,
               "age" => 42,
               "location" => "some location",
               "name" => "some name",
               "phone" => "some phone",
               "status" => "some status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/contacts", contact: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update contact" do
    setup [:create_contact]

    test "renders contact when data is valid", %{conn: conn, contact: %Contact{id: id} = contact} do
      conn = put(conn, ~p"/api/contacts/#{contact}", contact: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/contacts/#{id}")

      assert %{
               "id" => ^id,
               "age" => 43,
               "location" => "some updated location",
               "name" => "some updated name",
               "phone" => "some updated phone",
               "status" => "some updated status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, contact: contact} do
      conn = put(conn, ~p"/api/contacts/#{contact}", contact: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete contact" do
    setup [:create_contact]

    test "deletes chosen contact", %{conn: conn, contact: contact} do
      conn = delete(conn, ~p"/api/contacts/#{contact}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/contacts/#{contact}")
      end
    end
  end

  defp create_contact(_) do
    contact = contact_fixture()
    %{contact: contact}
  end
end
