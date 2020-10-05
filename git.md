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


### submodules

Git submodules enables developer to link a third party repo to the current repo.

### reading

- [implement git yourself](https://wyag.thb.lt/)
- [github doc](https://help.github.com/en/github/using-git/caching-your-github-password-in-git)


# CI/CD

- harbour
- rancher
- [how to build common database in pipeline yml?](https://confluence.atlassian.com/bitbucket/how-to-run-common-databases-in-bitbucket-pipelines-891130454.html
)

### chatbot deployment solutions

- probot
- buildkites
- Github Action
- Git submodules enables developer to link a third party repo to the current repo.

## FAQ

1. case-senstive issue
```bash
# on osx filename are case insensitive by default, this gives some hassle when you uppercase/lowercase you files
# https://stackoverflow.com/questions/17683458/how-do-i-commit-case-sensitive-only-filename-changes-in-git
git config core.ignorecase false
git mv -f OldFileNameCase newfilenamecase
```

2. [How to ask git to ignore tracked files?](https://stackoverflow.com/questions/1274057/how-to-make-git-forget-about-a-file-that-was-tracked-but-is-now-in-gitignore/20241145#20241145)

```bash
# straight but not safe
git rm --cached <file>
git rm -r --cached <folder>

# better solution
git update-index --skip-worktree <file>

```

3. how to stop tracking deleted remote branches

`git remote prune origin`