defmodule AddressBookWeb.V1.AccountController do
  use AddressBookWeb, :controller

  alias AddressBook.Accounts
  alias AddressBook.Accounts.Account
  alias AddressBookWeb.Auth.ErrorResponse

  action_fallback AddressBookWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def sign_up(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params) do
      conn
      |> put_status(:created)
      |> render(:show, account: account)
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.sign_in(email, password) do
      {:ok, account, token} ->
        conn
        |> put_status(:ok)
        |> render(:access_token, %{account: account, token: token})

      {:error, :unauthorized} ->
        raise ErrorResponse.Unauthorized, message: "Invalid credentials"
    end
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
