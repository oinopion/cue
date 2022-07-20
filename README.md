# Cue: A virtual waiting room

Cue is an Open Source project aiming to make it easy to deploy and run *a
virtual waiting room* (also knows as virtual queue or virtual waiting line).

A virtual waiting room is useful to protect a website from sudden traffic
spikes, ie. during flash sales.

## Use cases
*E-commerce*

Imagine a flash sale of designer sneakers: an e-commerce website
has 200 pairs of sneakers. They post an announcement to their social media that
the sale will start on Friday noon. On Friday 11:30am, 20 000 people arrive on
their website and all start refreshing the page in anticipation of sales start.
Because of amount of traffic, the website suffers performance issues and
potentially goes completely down. Even if they manage to sell the sneakers, the
users will not have a great time: all 20 000 will have high expectations of
actually purchasing the sneakers, but 19 800 of them will not be able to finish
the transaction. Everyone will have to experience poor performance and
intermittent errors.

If the website uses a virtual waiting room, the situation will be much better:
customers arriving on the website will be put in a virtual waiting room, issued
a sequential number and will be released to the website at a constant speed that
the website is able to handle well. Users with low number will have high
expectation of making the purchase and a high chance of actually purchasing.
Customer with high numbers will have progressively smaller chance of making the
purchase but also lower expectation of being able to purchase.


## Development

This project is set up for development with [VS
Code](https://code.visualstudio.com) & [Dev
Containers](https://code.visualstudio.com/docs/remote/containers) giving all
maintainers an easy way to setup working development environment.

### Setting up VS Code

To set up VS Code for development with containers you will need to install
[Docker](https://www.docker.com/products/personal/) and VS
Code. If you're on macOS, you'll also need
[Rosetta](https://support.apple.com/en-us/HT211861). We also recommend using
[Homebrew](https://brew.sh) to install software on your Mac.

Here's what you need to do on a fresh Mac:

```
# Install Rosetta
softwareupdate --install-rosetta

# Install Homebrew
# ... see https://brew.sh for instructions

# Use Homebrew to install VS Code and Docker Desktop
brew install --cask docker visual-studio-code
```

At this point you probably want to turn on VirtioFS in Docker Desktop settings.

When you open VS Code point it to a working checkout of this repo and you should
see a pop-up with "Reopen in Container". That builds and starts Docker
containers using definitions from
[docker-compose.yml](.devcontainer/docker-compose.yml). Further settings are in
[devcontainer.json](.devcontainer/devcontainer.json).

### Development tasks supported by VS Code setup

* Running mix commands in the VS Code terminal

  When you open the project in VS Code in container mode, you'll be able to run
  terminal in the main dev container. It's configured for Elixir development,
  ie. mix tasks, like `mix test` and `mix deps.get`

* Debugging in VS Code

  VS Code has a [built-in visual
  debugger](https://code.visualstudio.com/docs/editor/debugging) which is
  configured via [launch.json](.vscode/launch.json)). Currently this repo has
  two debugger launch configs:

  1. `mix test` - this runs all tests
  2. `mix phx.server` - this runs Phoenix server

* Running Postgres

  Postgres is started in it's own container. It's available both from within the
  main dev container (at `db:5432`) and from the host machine (via forwarded
  port, at `localhost:5432`). When the container is first created, an app-specific
  use is created with username & password set to `cue`.

  The main dev container also has `psql` (postgres client) installed and you can
  use it to explore the database quickly. Run `psql` for the dev database and
  `psql cue_test` for the test one.
