# e

## About

`e` is a small Bash utility that opens the most recently modified text file in the current directory.

It scans only the current folder, filters files by MIME type (`text/*`), sorts by newest first, and opens the selected file in `nvim` (or `vim` as fallback). If the file is not writable, it opens with `sudo`.

## Installation

### Prerequisites

- Linux with Bash
- One editor installed: `nvim` or `vim`
- Common command-line tools: `find`, `file`, `sort`, `grep`, `sudo`

### Install Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/llagerlof/e.git
   cd e
   ```
2. Make the script executable (if needed):
   ```bash
   chmod +x ./e
   ```
3. Optional: add it to your PATH:
   ```bash
   sudo install -m 755 ./e /usr/local/bin/e
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
