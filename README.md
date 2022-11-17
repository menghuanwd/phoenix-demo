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

### Commands
```shell
mix phx.new credit_stake --no-html --no-assets --binary-id

mix deps.get

mix ecto.create

mix phx.gen.json Database Bank banks name:string:unique

mix ecto.migrate
mix ecto.rollback

mix ecto.drop
```

### Startup
```shell
mix phx.server
iex -S mix phx.server
```

### Format
```shell
mix format
```

### Dashboard
```shell
http://127.0.0.1:4000/dashboard
```

### Swagger
```shell
  mix phx.swagger.generate
```
