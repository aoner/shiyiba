defmodule Sky.Repo do
  use Ecto.Repo, otp_app: :sky, adapter: Ecto.Adapters.Postgres
  # use Ecto.Repo, otp_app: :mipha, adapter: Ecto.Adapters.Postgres

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end
