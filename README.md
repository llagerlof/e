# e

## About

`e` is a small Bash utility that opens the most recently modified text file in the current directory.

It scans only the current folder, filters files by MIME type (`text/*`), sorts by newest first, and opens the selected file using the first available editor in this order: `nvim`, `vim`, `nano`, `vi`, `less`. If the file is not writable, it opens with `sudo`.

## Installation

### Prerequisites

- Linux with Bash
- One editor installed: `nvim`, `vim`, `nano`, `vi`, or `less`
- Common command-line tools: `find`, `file`, `sort`, `grep`, `sudo`

### Install Steps

Use this default setup:

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

This keeps the project at `~/repos/e`, ensures `e` is executable, and creates `~/.local/bin/e` only when it does not already exist.

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
