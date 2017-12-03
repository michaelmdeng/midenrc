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

## Cloning this homeshick repo
Clone this repository as a homeshick repo by:
```
$HOME/.homesick/repos/homeshick/bin/homeshick clone https://gitlab.com/michaelmdeng/DotConfig.git
```

## Adding files to a homeshick repo
You can navigate to this specific homeshick repo by running the `homeshick cd DotConfig` command. Then, you can track specific config files using the `homeshick track DotConfig <filePath>`. Once files are tracked and added, you can use git to manage commits to this repo and pushing/pulling changes to/from this remote.
