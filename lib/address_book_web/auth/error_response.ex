defmodule AddressBookWeb.Auth.ErrorResponse.Unauthorized do
  defexception message: "Unauthorized", plug_status: :unauthorized
end

defmodule AddressBookWeb.Auth.ErrorResponse.NotFound do
  defexception message: "Not found", plug_status: :not_found
end
