const activate = (oni) => {
  oni.input.unbind("<c-g>") // make C-g work as expected in vim
  oni.input.bind("<s-c-g>", () => oni.commands.executeCommand("sneak.show")) // You can rebind Oni's behaviour to a new keybinding
};

module.exports = {
  activate,
  "achievements.enabled": false, // Turn off achievements tracking / UX
  "autoClosingPairs.enabled": false, // disable autoclosing pairs
  "commandline.mode": false, // Do not override commandline UI
  "editor.fontSize": "13px",
  "editor.textMateHighlighting.enabled": false, // Use vim syntax highlighting
  "learning.enabled": false, // Turn off learning pane
  "oni.hideMenu": true, // Hide default menu, can be opened with <alt>
  "oni.loadInitVim": true, // Load user's init.vim
  "oni.useDefaultConfig": false, // Do not load Oni's init.vim
  "sidebar.enabled": true,
  "statusbar.enabled": false,
  "tabs.mode": "tabs",
  "wildmenu.mode": false, // Do not override wildmenu UI,
}
