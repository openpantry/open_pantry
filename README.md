# OpenPantry
## A management system for pantry programs to help people eat healthy meals with dignity

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Git clone https://github.com/MasbiaSoupKitchenNetwork/nutes locally and run make, modifying if necessary to point at your Postgres DB and the directory path to your local copy in imports.sql (requires golang to build data_cleanup tool)
  * Add seed data with `mix run priv/repo/seeds.exs`
  * Install Node.js dependencies with `yarn install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Learn more

  * Masbia Pantry: http://www.masbia.org/pantry
  * Volunteer to help develop this app, or other work with Masbia: http://www.masbia.org/volunteer_signup
