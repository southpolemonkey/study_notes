# Git

## Set Up

### ssh setup

Two methods to authorize:
- ssh
- https(personal token)

### source behind proxy

```bash
# .gitconfig
[http]
    proxy = localhost:<port>
```

### Sync Fork

```bash
git remote add upstream <upstream_repo_url>
git fetch upstream
git checkout master # master branch of your forked local repo
git merge upstream/<branch_name>:q

```

### How to protect branch?

Protection includes following scenarios:
- disallow forced push into certain branches
- restrict commit directly into master branche

https://stackoverflow.com/a/38866304/6716236

### CI/CD

- harbour
- rancher
- [how to build common database in pipeline yml?](https://confluence.atlassian.com/bitbucket/how-to-run-common-databases-in-bitbucket-pipelines-891130454.html
)

### submodules
Git submodules enables developer to link a third party repo to the current repo.

### reading
[implement git yourself](https://wyag.thb.lt/)
[github doc](https://help.github.com/en/github/using-git/caching-your-github-password-in-git)

### chatbot deployment solutions
probot
buildkites
Github Action
Git submodules enables developer to link a third party repo to the current repo.

