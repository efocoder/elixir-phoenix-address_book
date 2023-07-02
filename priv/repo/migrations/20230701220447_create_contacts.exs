defmodule AddressBook.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :age, :integer
      add :location, :string
      add :phone, :string
      add :status, :string

      timestamps()
    end

    create unique_index(:contacts, [:phone])
  end
end
