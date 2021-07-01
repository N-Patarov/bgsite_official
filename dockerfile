FROM elixir:1.9-alpine as build


RUN apk add --update git build-base nodejs npm yarn
RUN mkdir /app
WORKDIR /app
RUN mix do local.hex --force, local.rebar --force
ENV MIX_ENV=prod


COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile


COPY assets assets

RUN cd assets && npm install && npm rebuild node-sass && npm run deploy
RUN mix phx.digest


COPY priv priv
COPY lib lib
RUN mix compile


RUN mix release


FROM alpine:3.9 AS app


RUN apk add --update bash openssl postgresql-client

EXPOSE 4000
ENV MIX_ENV=prod


RUN mkdir /app
WORKDIR /app


COPY --from=build /app/_build/prod/rel/bgsite_official .
COPY entrypoint.sh .
RUN chown -R nobody: /app
USER nobody

ENV HOME=/app
CMD ["bash", "/app/entrypoint.sh"]
