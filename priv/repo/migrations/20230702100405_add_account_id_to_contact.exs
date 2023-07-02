defmodule AddressBook.Repo.Migrations.AddAccountIdToContact do
  use Ecto.Migration

  def change do
    alter table("contacts") do
      add :account_id, references(:accounts, type: :uuid)
    end

    create index(:contacts, [:account_id])
  end
end
