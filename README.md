# CreditStake

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Usage

### Postgres
```shell
docker run --name phoenix-postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 5501:5432 -d postgres
```

```shell
mix hex.info
mix hex.config
```

### Commands
```shell
mix local.hex
mix archive.install hex phx_new
mix phx.new credit_stake --no-html --no-assets --binary-id

mix deps.get
rm -rf ~/.hex
HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=1200 mix deps.get

mix ecto.create
MIX_ENV=test mix ecto.create
mix phx.gen.json Database Bank banks name:string:unique

mix ecto.migrate
mix ecto.rollback
mix ecto.drop

mix ecto.gen.migration create_articles
mix ecto.gen.migration add_publish_at_to_article

mix run priv/repo/seeds.exs
```

### Startup
```shell
mix phx.server
iex -S mix phx.server
```

### Deploy Docker
```shell
mix phx.gen.release --docker
mix phx.gen.secret

ENV SECRET_KEY_BASE="x1jq8T5ik/2A34D0qKxDPEC70D2O4pmLqY9eB3OEvgdG+OEsm/28j6kPSRR1EJng"
ENV DATABASE_URL="ecto://USER:PASS@HOST/credit_stake"

docker build . -t credit_stake
docker run --rm --name credit_stake_1 credit_stake
```

### Crawler

services/crawler

### Format
```shell
mix format
mix credo
mix credo list
```

### Dashboard
```shell
http://127.0.0.1:4000/dashboard
```

### Swagger
```shell
  mix phx.swagger.generate
```

### Functions

* restful api
* graphql api

## What?

* defprotocol
* defimpl
* defmacro
