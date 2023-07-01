defmodule AddressBookWeb.Router do
  use AddressBookWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AddressBookWeb do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      post "/accounts/sign_up", AccountController, :sign_up
      post "/accounts/sign_in", AccountController, :sign_in
    end
  end

  if Application.compile_env(:address_book, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: AddressBookWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
