defmodule AddressBookWeb.V1.AccountJSON do
  alias AddressBook.Accounts.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  def access_token(%{account: account, token: token}) do
    %{id: account.id, email: account.email, access_token: token}
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email,
      nickname: account.nickname,
      created_at: account.inserted_at
    }
  end
end
