brew "elixir"
`brew install wget` unless `which wget` && $?.success? # installations via brew DSL as above occur after ruby shell commands below, so ensuring this is run first, new macs don't have wget
`brew install yarn` unless `which yarn` && $?.success?
postgres_app = "Postgres-2.0.3.dmg"
unless File.exists?(postgres_app) || File.exists?("/Applications/Postgres.app/Contents/Versions/latest/bin/psql")
  `sudo mkdir -p /etc/paths.d && echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp`
  `wget https://github.com/PostgresApp/PostgresApp/releases/download/v2.0.3/Postgres-2.0.3.dmg`
  `open "#{postgres_app}"`
  `cd assets && yarn`
end
