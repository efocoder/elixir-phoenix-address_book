defmodule AddressBook.Friends.Contact do
  use Ecto.Schema
  import Ecto.Changeset
  alias AddressBook.Accounts.Account

  @derive {
    Flop.Schema,
    filterable: [:name], sortable: [:name], max_limit: 10, default_limit: 2
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "contacts" do
    field :age, :integer
    field :location, :string
    field :name, :string
    field :phone, :string
    field :status, :string, default: "active"
    belongs_to :account, Account

    timestamps()
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:name, :age, :location, :phone, :status, :account_id])
    |> validate_required([:name, :age, :location, :phone, :status, :account_id])
    |> validate_length(:phone, min: 10, max: 10)
    |> unique_constraint(:phone)
  end
end
