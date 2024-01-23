# iris' dotfiles

The `deploy.sh` script in this repo will set things up on a non-NixOS
system.

## pathmap

If something should be linked in, it should be present in `pathmap`.
The `pathmap` file specifies what goes where, as a space-delimited list of:

- source path, relative to the root of this repo
- destination path, relative to user home directory
- file mode, as an octal number
