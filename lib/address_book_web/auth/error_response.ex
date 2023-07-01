defmodule AddressBookWeb.Auth.ErrorResponse.Unauthorized do
  defexception message: "Unauthorized", plug_status: :unauthorized
end
