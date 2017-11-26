[![Build Status](https://travis-ci.org/openpantry/open_pantry.svg?branch=master)](https://travis-ci.org/openpantry/open_pantry)
# OpenPantry
## A management system for pantry programs to help people eat healthy meals with dignity

  * NOTES:
    * We are moving towards a SaaS like model, with one subdomain per facility, and facilities are managed by super-admins or by facility specific admins
    * Masbia has several locations, but we're trying to validate the scope and use-case for other organizations, please get in touch if you work with one 
    * Users are created/managed per facility on a user_selections page, and globally in a /manage/users page.
    * Food recipients are managed as users and can be logged in via magic login-links to be clicked on or emailed to them
    * We've been using ZenHub chrome extension for project management but this has caused some confusion, so we may move away from it...
    * Some mockups and UX flow for where we're trying to head are posted [here](https://invis.io/QPBK7WPB3).  
    * We initially attempted to make this multi lingual from the start but have largely deferred this work until things are more stable.
      * We have partial translations started for 9 languages
      * We have thousands of foods from USDA nutritional database ready for dynamic translation
      * We are using POEditor.com for static site translation, contribute to translations here: https://poeditor.com/join/project/wBfgEEUCht
      * We probably need to move to a database driven translation system for foods, given the quantity we are trying to manage, but we still need translation help.
      * Our curent best source for food images, facts and translations may be https://us.openfoodfacts.org/ but we started with USDA database and much work is needed to leverage/combine and rework the data model to pull photos and translations from openfoodfacts

  * Getting started with development:
    * Mac homebrew:
      * ensure homebrew is installed (instructions at https://brew.sh/ or paste `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"` into terminal)
      * brew bundle
        * This will install elixir, erlang, yarn, and download Postgres.app which has postgis preinstalled
        * It will cd into assets directory and install npm packages via yarn
        * You can use another postgres, but you may have to manually install postgis
      * run from open_pantry dir `mix do deps.get, ecto.create, ecto.migrate, run priv/repo/seeds.exs`
      * Expose an env var with some value in your bash config for `GUARDIAN_SECRET_KEY`, e.g. `export GUARDIAN_SECRET_KEY="A not very secret dev only key"`
      * Start Phoenix endpoint with `mix phx.server`, or `iex -S mix phx.server` (this gives a server and REPL/console in one window)
    * Docker/docker-compose (fake, factory generated data but no dependencies)
      * Install docker (on most systems this also installs docker-compose)
      * Clone the OpenPantry repo and cd into directory
      * Run `docker-compose run setup`
      * Run `docker-compose up web`
      * Temporary work-around steps for known bug in docker-compose setup:
        * Install node package manager if not already present via `npm install`
        * Install yarn via `npm install -g yarn`
        * run `cd assets` from open_pantry directory
        * run `yarn`
    * Local/native development on Mac/Linux manually, without automation from `brew bundle` via Brewfile above (detailed instructions only for Mac at present, similar for linux)
      * Install Postgres (Mac)
          * Download and install the Postgresapp.com from [their site](https://postgresapp.com/documentation/install.html)
              * Execute the following command in Terminal to configure your $PATH, and then close & reopen the window:
              `sudo mkdir -p /etc/paths.d &&
                echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp`
          * Alternatively install Postgres with Homebrew
              * Execute (`brew install postgres`) in Terminal
      * if using Postgres.app you must initialize a data directory after installing, and follow instructions for adding CLI tools to your Terminal path...  `which psql` but succeed when done
        * (instructions defaulting to Mac below... for simplicity, linux users extrapolate, Windows, I have no idea, PR's with instructions for either/both welcome)
      * Install Elixir/Erlang (`brew install elixir`)
      * Install NPM and yarn (`brew install node && npm install -g yarn`)
      * Clone this repository locally, `git clone git@github.com:openpantry/open_pantry.git`
      * cd into the directory `cd open_pantry`
      * Download database from s3 via `wget https://s3.amazonaws.com/open-pantry-dev/openpantry_dev.dump`
        * Note we had problems with this dump being improperly generated recently.  I beleive the problem is fixed, but if you downloaded previously or have problems please contact someone for support, it's probably not your fault!
        * Dumps and restores are based on the method described here: https://devcenter.heroku.com/articles/heroku-postgres-import-export
      * Install Elixir package dependencies with `mix deps.get`
      * Create the database in Postgres with `mix ecto.create`, assuming default password etc in config works.
      * Migrate the database to add migrations since dump was created, via `mix ecto.migrate`
      * Import the dump to the database via `pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d open_pantry_dev openpantry.dump`
      * Install Node.js dependencies with `yarn install`
      * Start Phoenix endpoint with `mix phx.server`, or `iex -S mix phx.server` (this gives a server and REPL/console in one window)
    * ALTERNATIVELY (and with much less detail), if you DON'T WANT TO USE the dump file referenced above/want to generate a dump from scratch, the above dump was generated with a complete USDA food/nutrient database approximately as below, along with non-dump steps above:
      * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
      * Git clone https://github.com/openpantry/nutes locally and run make, modifying if necessary to point at your Postgres DB and the directory path to your local copy in imports.sql (requires golang to build data_cleanup tool)
      * Add seed data with `mix run priv/repo/seeds.exs` but modify to leave out foods/stocks as these are fakes generated by factories, you have real food from USDA

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Learn more

  * Masbia Pantry: http://www.masbia.org/pantry
  * Volunteer to help develop this app, or other work with Masbia: http://www.masbia.org/volunteer_signup
