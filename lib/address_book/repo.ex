defmodule AddressBook.Repo do
  use Ecto.Repo,
    otp_app: :address_book,
    adapter: Ecto.Adapters.Postgres
end
