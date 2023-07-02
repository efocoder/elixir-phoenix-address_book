defmodule AddressBookWeb.V1.ContactController do
  use AddressBookWeb, :controller

  alias AddressBook.Friends
  alias AddressBook.Friends.Contact

  action_fallback AddressBookWeb.FallbackController

  def index(conn, params) do
    with {:ok, {contacts, meta}} <-
           Friends.list_contacts(Guardian.Plug.current_resource(conn), params) do
      conn
      |> put_status(:ok)
      |> render(:index, meta: meta, contacts: contacts)
    end

    # contacts = Friends.list_contacts(Guardian.Plug.current_resource(conn), params)

    # render(conn, :index, contacts: contacts)
  end

  @spec create(any, map) :: any
  def create(conn, %{"contact" => contact_params}) do
    with {:ok, %Contact{} = contact} <-
           Friends.create_contact(
             Map.merge(contact_params, %{"account_id" => Guardian.Plug.current_resource(conn).id})
           ) do
      conn
      |> put_status(:created)
      |> render(:show, contact: contact)
    end
  end

  def show(conn, %{"id" => id}) do
    contact = Friends.get_contact!(id, Guardian.Plug.current_resource(conn))
    render(conn, :show, contact: contact)

    #  case Friends.get_contact!(id, Guardian.Plug.current_resource(conn)) do
    #   contact when not is_nil(contact) ->
    #     render(conn, :show, contact: contact)

    #   nil ->
    #     raise ErrorResponse.NotFound, message: "Contact not found"
    # end
  end

  def update(conn, %{"id" => id, "contact" => contact_params}) do
    contact = Friends.get_contact!(id, Guardian.Plug.current_resource(conn))

    with {:ok, %Contact{} = contact} <- Friends.update_contact(contact, contact_params) do
      render(conn, :show, contact: contact)
    end
  end

  def delete(conn, %{"id" => id}) do
    contact = Friends.get_contact!(id, Guardian.Plug.current_resource(conn))

    with {:ok, %Contact{}} <- Friends.delete_contact(contact) do
      send_resp(conn, :no_content, "")
    end
  end
end
