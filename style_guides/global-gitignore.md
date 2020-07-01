There are certain files created by particular editors, IDEs, operating systems, etc., that do not belong in a repository. But adding system-specific files to the repo's `.gitignore` is considered a poor practice. This file should only exclude files and directories that are a part of the package that should not be versioned (such as the `node_modules` directory) as well as files that are generated (and regenerated) as artifacts of a build process.

All other files should be in your own global gitignore file. Create a file called `.gitignore` in your home directory and add anything you want to ignore. You then need to tell git where your global gitignore file is.

#### Mac
    git config --global core.excludesfile ~/.gitignore

#### Windows
    git config --global core.excludesfile %USERPROFILE%\.gitignore

This will result in an entry in your .gitconfig that looks like this:

    [core]
        excludesfile = {path-to-home-dir}/.gitignore

## Global .gitignore contents

Depending on your OS and tools, the following contains sample of what you might want to include. When you run `git status` before adding any files to your local repo, check to see if any files don't belong. Add them to your global gitignore as appropriate.

```
# Node
npm-debug.log

# Mac
.DS_Store

# Windows
Thumbs.db

# WebStorm
.idea/

# vi
*~

# General
log/
*.log

# etc...
```

## WebStorm

If you use WebStorm, you will also need to copy your global gitignore contents to its Ignored Files dialog.

#### Mac
WebStorm | Preferences | Version Control | Ignored Files

#### Windows
File | Settings | Version Control | Ignored Files
