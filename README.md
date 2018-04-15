# Habitibot

Habitibot is a bot for automating boring tasks on Habitica.

For now it is fairly minimal, since it only allows you to automatically accept
your party's quests.

## Gift economy

I publish this [work as a
gift](https://charleseisenstein.net/essays/gift-circles-and-the-monetization-of-everything/),
and I hope it will motivate you to gift in return if so you see fit.

## As a service

This project run for free at https://habitibot.com. You are welcome to use this
hosted version, or to deploy your own.

You must know that because of the way Habitica works, I am forced to store your
API secret, and this basically could give me full power over your account.

## Running it locally

Assuming [Elixir](https://elixir-lang.org/install.html) and
[NodeJS](https://nodejs.org/en/) are installed on your computer, you can simply
run:

```
make serve
```

in your favourite terminal to launch the server

## Development

I'm trying to maintain a development environment with this project. This
environment depends of Docker & Docker Compose. It will run Habitica locally so
one can test changes without having to rely on the internet.

You can start the environment with:

```
make docker-up
```

And you can find the test groups and account details in `docker/README`.

## Licence

This project is provided under the Affero General Public Licence 3.0+ (or
agpl-3.0+).

Copyright (C) 2018 Matthieu Maury <m@mayeu.me>

