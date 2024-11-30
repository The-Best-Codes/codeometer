# Codeometer

Codeometer is a powerful CLI tool for analyzing code statistics across your projects.

## Description

Codeometer provides detailed code analysis for your projects, helping you understand your codebase size, composition, and structure. It automatically detects project types and provides relevant statistics while excluding auto-generated code.

### Features

- Automatic project type detection (Node.js, Python, Java, Rust, Go, Ruby, PHP, C/C++)
- Counts lines of code across multiple file types
- Distinguishes between hand-written and auto-generated code
- Optional comment line counting
- Support for hidden files and directories
- Colored and formatted output
- Progress bar for large projects
- Detailed statistics and percentages

## Installation

Codeometer is packaged for Debian-based systems. To install, download the DEB file and open it in an app installer.

If you don't have an app installer, download the file and run this command:

```bash
sudo dpkg -i codeometer_1.2.0.deb
```

## Dependencies

- bash (version 4.0 or later)
- find
- wc
- awk
- tput (for terminal formatting)

## Usage

Basic usage:

```bash
codeometer /path/to/project
```

Available options:

```bash
codeometer [OPTIONS] /path/to/project

Options:
  --no-color       Disable colored output
  --no-format      Disable formatted output
  --hidden         Include hidden files and directories
  --comments       Count and display comment statistics
  --version        Display version information
  --help          Display this help message
```

## Examples

Count lines in a Python project:

```bash
codeometer /path/to/python/project
```

Include hidden files and count comments:

```bash
codeometer --hidden --comments /path/to/project
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

Codeometer is licensed under the MIT License.

## Contact

Maintainer: [BestCodes](https://bestcodes.dev)

## Links

- [GitHub Repository](https://github.com/The-Best-Codes/codeometer)
