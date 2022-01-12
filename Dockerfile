FROM mcr.microsoft.com/vscode/devcontainers/base:debian

COPY . /tmp/dotfiles
WORKDIR /tmp/dotfiles
RUN ./install.sh
