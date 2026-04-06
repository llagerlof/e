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
