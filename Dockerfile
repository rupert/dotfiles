FROM mcr.microsoft.com/vscode/devcontainers/base:debian

COPY install.sh .
RUN ./install.sh
