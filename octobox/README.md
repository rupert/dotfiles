# Octobox

[Create a GitHub app](https://developer.github.com/apps/building-github-apps/creating-a-github-app/) and set the callback URL to: http://localhost:5000/auth/github/callback

```
env GITHUB_CLIENT_ID=x GITHUB_CLIENT_SECRET=x docker-compose up --detach
```

See the [installation guide](https://github.com/octobox/octobox/blob/master/docs/INSTALLATION.md).
