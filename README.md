# Repository for my custom .config files

Repository for syncing my config files across multiple machines using
[`homeshick`](https://github.com/andsens/homeshick).

# Usage

## Installing homeshick

Install homeshick using the command:

```
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
```

## Cloning this homeshick repo

Clone this repository as a homeshick repo by:

```bash
$HOME/.homesick/repos/homeshick/bin/homeshick clone https://github.com/michaelmdeng/DotConfig.git
```

## Adding files to a homeshick repo

You can navigate to this specific homeshick repo by running:

```bash
homeshick cd midenrc
```

You can track specific config files by running:

```bash
homeshick track midenrc <filePath>
```

Once files are tracked and added, you can use git to manage commits to this
repo and pushing/pulling changes to/from this remote.

# Reference

For more information, see [homeshick
Wiki](https://github.com/andsens/homeshick/wiki/Tutorials).

