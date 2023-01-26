FROM elixir:1.14.2-alpine
WORKDIR /app
ENV MIX_ENV=prod
COPY . .
RUN mix local.hex --force && mix local.rebar --force
RUN rm -rf _build && \
    mix deps.get && \
    mix compile && \
    mix release


FROM elixir:1.14.2-alpine
ENV MIX_ENV=prod
WORKDIR /app
COPY --from=0 /app/_build/prod /app

ENTRYPOINT ["/app/rel/elixir_ms/bin/elixir_ms"]
CMD ["start"]