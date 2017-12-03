# Repository for custom .config files.
Repository for using the same config files across multiple machines using homeshick.

# Usage
## Resources
For more information, see [homeshick Wiki](https://github.com/andsens/homeshick/wiki/Tutorials).

## Installing homeshick
Install homeshick using the command:
```
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
```

## Setting up a new homeshick repo
In order to set up a new repo, use the command `homeshick generate <repoName>`. You can then use git to add files and make commits, and also connect to a remote repo.

## Cloning a homeshick repo
Clone a repository as a homeshick repo by:
```
$HOME/.homesick/repos/homeshick/bin/homeshick clone <repoURL>
```

## Adding files to a homeshick repo
You can navigate to the specific homeshick repo by running the `homeshick cd <repoName>` command. Then, you can track specific config files using the `homeshick track <filePath>`. Once files are tracked and added, you can use git to manage commits to the repo and pushing/pulling changes to/from the remote.
