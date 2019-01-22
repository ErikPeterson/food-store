# README

## Installation

You will need to have PostgreSQL > 9, and Ruby at 2.5.0 installed. If you don't already have bundler installed, do so with `gem install bundler`.

To set up, first clone this repository and enter the project directory.

Now we need to provision the app with the secret key used for signing JWTs. We'll use a `.env` file in the project directory to do so. Run `rails secret` to generate a key, then copy and paste into your `.env` file like so:

```
DEVISE_JWT_SECRET_KEY=YOUR_KEY_HERE
```

Then run the following in the project directory:

```
bundle install
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
bundle exec rails s
```

This will install dependencies, create the local database, seed it with a base set of data, and start a server at `localhost:3000`