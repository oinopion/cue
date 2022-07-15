# Cue

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

# Install Homebrew - see brew.sh for instructions
...

# Use Homebrew to install VS Code and Docker Desktop
brew install --cask docker visual-studio-code
```

At this point you probably want to turn on VirtioFS in Docker Desktop settings.

When you open VS Code point it to a working checkout of this repo and you should
see a pop-up with "Reopen in Container". That builds and starts Docker
containers using definitions from
[docker-compose.yml](.devcontainer/docker-compose.yml). Futher settings are in
[devcontainer.json](.devcontainer/devcontainer.json).

### Development tasks supported by VS Code

* Running Postgres

  Postgres is started as it's own container. It's available both from within the
  main dev container (at `db:5432`) and from the host machine (at `localhost:5432`).

