# Action for Children

A prototype for enabling relationships between parents and support workers

### Why?

Action for children runs support groups where parents meet with family support workers so they can talk to them about any questions they have about their child's wellbeing. The family support workers can then build a relationship with the parent to help spot any problems earlier and better support the parent.

With the power of realtime communication via the internet this prototype hopes to discover if this service is viable online.

### How?

The prototype will be a web app that uses the [intercom messaging widget](https://www.intercom.com/) to allow a parent to talk directly to family support worker. The widget has a text chat interface with a list of recent conversations plus options to be contacted by email or to request a callback via phone later if the family support worker is not online at the time.


### Installation and Setup

To get up and running - make sure you have installed:

+ [`node.js`](https://nodejs.org/en/download/)
+ [`elixir`](http://elixir-lang.org/install.html)
+ [`phoenix`](http://www.phoenixframework.org/docs/installation) - v1.3
+ [`postgres`](https://www.postgresql.org/download/)

after installing, to install the dependencies run:

```sh
> mix deps.get && cd assets && npm install
```

make sure postgres is running and then run

```sh
> mix ecto.create && mix ecto.migrate
```

this creates a local database

after the dependencies are installed and database setup, run:

```sh
> mix phx.server
```

and visit `localhost:4000` to see the app running

### Deployment

The app is currently hosted on `heroku`, with the following versions:

+ `staging` (`https://action-for-children-staging.herokuapp.com`)
+ `production` (`https://action-for-children.herokuapp.com`)

Heroku is set up to automatically deploy from `staging` and `master` branches (to staging and production versions respectively).

### Environment Variables

to add the env vars to the app, make a `.env` in the root of your app and add this (with your own vars in place)

```env
INTERCOM_ACCESS_TOKEN="<intercom access token>"
INTERCOM_APP_ID="<app id>"
SECRET_KEY_BASE="<secret key base>" -- generated using mix phx.gen.secret
```

the following env vars are also set on heroku but are not as relevant to development

```env
export DATABASE_URL="heroku postgres db url"
export POOLSIZE=18
```

### Tests

Tests are in the `test` directory, To run the tests:

```sh
> mix test
```

Before pull requests can be merged into `staging` or `master` the tests run and must pass on `Circle CI`

### Circle CI Setup

The configuration for running the test suite on Circle is included in `/circle.yml` and `/.tool-versions`. The [`asdf` package manager](https://github.com/asdf-vm/asdf) is used to install `Erlang` and `Elixir` and to cache these installations if they have not changed since the last build. `/.tool-versions` contains the version numbers to install. Full details can be found on the following article -

[Simple CircleCI Config for Phoenix Projects](https://medium.com/@QuantLayer/simple-circleci-config-for-phoenix-projects-fc3ae271aff1)
