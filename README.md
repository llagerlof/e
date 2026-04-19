# e

## About

`e` is a small Bash utility that opens the most recently modified text file in the current directory.

It scans only the current folder, filters files by MIME type (`text/*`), sorts by newest first, and opens the selected file using the first available editor in this order: `nvim`, `vim`, `nano`, `vi`, `less`. If the file is not writable, it opens with `sudo`.

## Installation

### Prerequisites

- Linux with Bash
- One editor installed: `nvim`, `vim`, `nano`, `vi`, or `less`
- Common command-line tools: `find`, `file`, `sort`, `grep`, `sudo`

### Recommended: install only for the current user

This is the default setup for this project. It keeps the repository in `~/repos/e`, makes the script executable, and creates `~/.local/bin/e` only when it does not already exist:

```bash
mkdir -p ~/repos ~/.local/bin

if [ -d ~/repos/e/.git ]; then
   git -C ~/repos/e pull --ff-only
else
   git clone https://github.com/llagerlof/e.git ~/repos/e
fi

chmod +x ~/repos/e/e

if [ ! -e ~/.local/bin/e ]; then
   ln -s ~/repos/e/e ~/.local/bin/e
fi
```

If `~/.local/bin` is not already on your `PATH`, add it in your shell profile before using `e` from anywhere.

### Alternative: download only for the current user

If you do not want a local clone, download the script directly:

```bash
mkdir -p ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/llagerlof/e/main/e -o ~/.local/bin/e
chmod +x ~/.local/bin/e
```

### Alternative: install for everyone from a local clone

To make `e` available system-wide, keep the repository in a normal user's home directory and link it into `/usr/local/bin`:

```bash
mkdir -p ~/repos

if [ -d ~/repos/e/.git ]; then
   git -C ~/repos/e pull --ff-only
else
   git clone https://github.com/llagerlof/e.git ~/repos/e
fi

chmod +x ~/repos/e/e

if [ ! -e /usr/local/bin/e ]; then
   sudo ln -s "$HOME/repos/e/e" /usr/local/bin/e
fi
```

### Alternative: download for everyone

To install the script directly into `/usr/local/bin`:

```bash
tmpfile="$(mktemp)"
curl -fsSL https://raw.githubusercontent.com/llagerlof/e/main/e -o "$tmpfile"
chmod +x "$tmpfile"
sudo mv "$tmpfile" /usr/local/bin/e
```

## Usage

```bash
e [-h] [number]
```

- `-h`: include hidden files
- `number`: 1-based order of the newest text file to open (`1` means newest)

### Examples

Open the newest text file:
```bash
e
```

Open the second newest text file:
```bash
e 2
```

Include hidden files and open the newest match:
```bash
e -h 1
```

### Notes

- Searches only the current directory (`maxdepth=1`), not subdirectories.
- If no text files are found, the script exits with a message.
