# v

## About

`v` is a small Bash utility that opens the most recently modified text file in the current directory.

It scans only the current folder, filters files by MIME type (`text/*`), sorts by newest first, and opens the selected file in `nvim` (or `vim` as fallback). If the file is not writable, it opens with `sudo`.

## Installation

### Prerequisites

- Linux with Bash
- One editor installed: `nvim` or `vim`
- Common command-line tools: `find`, `file`, `sort`, `grep`, `sudo`

### Install Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/llagerlof/v.git
   cd v
   ```
2. Make the script executable (if needed):
   ```bash
   chmod +x ./v
   ```
3. Optional: add it to your PATH:
   ```bash
   sudo install -m 755 ./v /usr/local/bin/v
   ```

## Usage

```bash
v [-h] [number]
```

- `-h`: include hidden files
- `number`: 1-based order of the newest text file to open (`1` means newest)

### Examples

Open the newest text file:
```bash
v
```

Open the second newest text file:
```bash
v 2
```

Include hidden files and open the newest match:
```bash
v -h 1
```

### Notes

- Searches only the current directory (`maxdepth=1`), not subdirectories.
- If no text files are found, the script exits with a message.
