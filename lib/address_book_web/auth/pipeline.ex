defmodule AddressBookWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :address_book,
    module: AddressBookWeb.Auth.Guardian,
    error_handler: AddressBookWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
