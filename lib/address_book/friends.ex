defmodule AddressBook.Friends do
  @moduledoc """
  The Friends context.
  """

  import Ecto.Query, warn: false
  alias AddressBook.Repo

  alias AddressBook.Friends.Contact
  alias AddressBookWeb.Auth.ErrorResponse

  @doc """
  Returns the list of contacts.

  ## Examples

      iex> list_contacts()
      [%Contact{}, ...]

  """
  def list_contacts(account, params) do
    # Flop.validate_and_run(from(u in Contact, where: u.status == "active"), params, for: Contact)

    Contact
    |> where(account_id: ^account.id, status: ^"active")
    |> preload(:account)
    |> Flop.validate_and_run(params, for: Contact, repo: Repo)
  end

  @doc """
  Gets a single contact.

  Raises `Ecto.NoResultsError` if the Contact does not exist.

  ## Examples

      iex> get_contact!(123)
      %Contact{}

      iex> get_contact!(456)
      ** (ErrorResponse.NotFound)

  """
  def get_contact!(id, account) do
    Contact
    |> where(id: ^id, account_id: ^account.id, status: ^"active")
    |> preload(:account)
    |> Repo.one()
    |> case do
      contact when not is_nil(contact) ->
        contact

      nil ->
        raise ErrorResponse.NotFound, message: "Contact not found"
    end
  end

  @spec create_contact(
          :invalid
          | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: any
  @doc """
  Creates a contact.

  ## Examples

      iex> create_contact(%{field: value})
      {:ok, %Contact{}}

      iex> create_contact(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contact(attrs \\ %{}) do
    %Contact{}
    |> Contact.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, contact} -> {:ok, Repo.preload(contact, :account)}
      error -> error
    end
  end

  @doc """
  Updates a contact.

  ## Examples

      iex> update_contact(contact, %{field: new_value})
      {:ok, %Contact{}}

      iex> update_contact(contact, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contact(%Contact{} = contact, attrs) do
    contact
    |> Contact.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, contact} -> {:ok, Repo.preload(contact, :account)}
      error -> error
    end
  end

  @doc """
  Deletes a contact.

  ## Examples

      iex> delete_contact(contact)
      {:ok, %Contact{}}

      iex> delete_contact(contact)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contact(%Contact{} = contact) do
    contact
    |> Contact.changeset(%{status: "deleted"})
    |> Repo.update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contact changes.

  ## Examples

      iex> change_contact(contact)
      %Ecto.Changeset{data: %Contact{}}

  """
  def change_contact(%Contact{} = contact, attrs \\ %{}) do
    Contact.changeset(contact, attrs)
  end
end
