defmodule AddressBookWeb.V1.ContactJSON do
  alias AddressBook.Friends.Contact
  alias AddressBookWeb.Paginator

  @doc """
  Renders a list of contacts.
  """
  def index(%{contacts: contacts, meta: meta}) do
    Map.merge(Paginator.paginate(meta, "contacts"), %{
      data: for(contact <- contacts, do: data(contact))
    })
  end

  @doc """
  Renders a single contact.
  """
  def show(%{contact: contact}) do
    %{data: data(contact)}
  end

  defp data(%Contact{} = contact) do
    %{
      id: contact.id,
      name: contact.name,
      age: contact.age,
      location: contact.location,
      number: contact.phone,
      owner: %{
        id: contact.account.id,
        email: contact.account.email
      },
      status: contact.status
    }
  end
end
