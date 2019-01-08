use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :sky, SkyWeb.Endpoint,
  secret_key_base: "+wW4LcosprvftfG5l6D0Jj86CeqTVilFnQZCEPTPqYbDSNMUcJ8kUXSHbdJ8ZwuA"

# Configure your database
config :sky, Sky.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "",
  database: "sky_prod",
  pool_size: 15
