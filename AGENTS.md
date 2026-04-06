# Project Guidelines

## Code Style

- Treat `e` as a Bash script and keep changes compatible with common Linux Bash environments.
- Keep CLI behavior stable: `-h` includes hidden files and positional `number` is 1-based.
- Prefer small, explicit shell logic over complex abstractions.

## Architecture

- The project is a single executable script: `e`.
- `e` finds files in the current directory (`maxdepth=1`), sorts by modification time (newest first), filters to text files by MIME type, and opens the selected one in `nvim` or `vim`.
- If the selected file is not writable, the script escalates to `sudo`.

## Build And Test

- No build step.
- Syntax check before committing:
  - `bash -n ./e`
- Manual validation commands (interactive):
  - `./e`
  - `./e 2`
  - `./e -h 1`

## Conventions

- Keep dependencies minimal and shell-native (`find`, `file`, `sort`, `grep`, `sudo`, `vim`/`nvim`).
- Do not add recursive directory traversal unless explicitly requested.
- Update `README.md` when flags, arguments, or editor-selection behavior changes.
- When updating the script (new features, changing script behavior or fixing bugs) also update the script version using Semantic Versioning 2.0.0 specification.

## Installation Instructions For Agents

- When asked for install steps, provide one default option based on `~/repos/e` and `~/.local/bin/e`.
- First check `~/repos/e/.git`:
  - If present, run `git -C ~/repos/e pull --ff-only`.
  - If not present, run `git clone https://github.com/llagerlof/e.git ~/repos/e`.
- Ensure the script is executable with `chmod +x ~/repos/e/e`.
- Check whether `~/.local/bin/e` exists:
  - If it does not exist, create the symlink with `ln -s ~/repos/e/e ~/.local/bin/e`.
  - If it already exists, do not replace it unless the user explicitly asks.
