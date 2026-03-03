# Pony Zed Extension

Pony language support for the [Zed editor](https://zed.dev).

## About Pony

[Pony](https://www.ponylang.io/) is an open-source, object-oriented, actor-model, capabilities-secure, high-performance programming language. It features:

- **Memory safety** without garbage collection using reference capabilities
- **Data-race freedom** guaranteed at compile time
- **Actor-based concurrency** for high performance
- **Type safety** with static typing
- **Pattern matching** and modern functional programming features

## Features

This extension provides Pony language support for Zed, including:

- **Syntax highlighting** - Full syntax highlighting for Pony language constructs
- **Auto-indentation** - Smart indentation based on code structure
- **Code navigation** - Outline panel and breadcrumbs for quick navigation
- **Bracket matching** - Syntax-aware bracket pairing and rainbow brackets
- **Vim text objects** - Text objects for functions, classes, and comments (vim mode)
- **Corral tasks** - Built-in tasks for fetching dependencies and building projects
- **Language Server Protocol (LSP)** integration with the `pony-lsp` language server

> [!NOTE]
> The Pony language server is still in early development. Some features are not yet implemented in the server itself.

## Installation

### Prerequisites

To enable LSP features, install `pony-lsp`. On macOS and Linux one option is via Homebrew:

```bash
brew install ponyc
```

Alternitively, use [`ponyup`](https://github.com/ponylang/ponyup), or build from source via the [ponyc](https://github.com/ponylang/ponyc) Git repository.

### From Zed Extensions

Install the release directly from the Zed extensions panel:

1. Open Zed
2. Press `cmd-shift-x` (macOS) or `ctrl-shift-x` (Linux/Windows)
3. Search for "Pony"
4. Click Install

### Development Installation

To test this extension during development:

1. Open Zed
2. Navigate to the Extensions panel
3. Click "Install Dev Extension"
4. Select this repository directory

## Configuration

The extension exposes the following settings under `lsp.pony-lsp.settings` in your Zed `settings.json`:

- **`defines`** (optional) - A list of compile-time definitions.
- **`executable`** (optional) - Path to the `pony-lsp` binary. If not set, Zed will search for `pony-lsp` on your system PATH.
- **`ponypath`** (optional) - A list of additional directories to search for Pony packages.

### Configuring the LSP Server

1. Open Zed settings: `cmd-,` (macOS) or `ctrl-,` (Linux/Windows)
2. Add the following configuration:

```json
{
  "lsp": {
    "pony-lsp": {
      "settings": {
        "executable": "/path/to/pony-lsp",
        "ponypath": [
          "/path/to/project-a/packages",
          "/path/to/project-b/packages"
        ],
        "defines": [
          "MY_DEFINE_ONE",
          "MY_DEFINE_TWO"
        ]
      }
    }
  }
}
```

> [!NOTE]
> All options are optional! For example, if `pony-lsp` is already on your PATH, you can omit the `executable` setting.

## Usage

### Corral Tasks

The extension provides built-in tasks for Corral (Pony's package manager):

- **corral fetch** - Download dependencies defined in `corral.json`
- **corral run -- ponyc** - Build your project using Corral's package paths

To run a task:
1. Open the command palette: `cmd-shift-P` (macOS) or `ctrl-shift-P` (Linux/Windows)
2. Type "task" and select "task: spawn"
3. Choose a corral task from the list

## Development

### Prerequisites

- [Zed editor](https://zed.dev)
- [Rust](https://rustup.rs/) (required for building the extension)
- [pony-lsp](https://github.com/ponylang/ponyc) (optional, enables LSP features)

### Building

The extension includes Rust code for LSP integration and must be compiled:

```bash
cargo build --release
```

The tree-sitter-pony grammar is automatically fetched and compiled by Zed when you install the extension.

### Project Structure

```
pony-zed-extension/
├── Cargo.toml          # Rust project manifest
├── extension.toml      # Extension metadata and LSP registration
├── src/
│   └── pony.rs         # LSP integration code
├── languages/          # Language definitions
│   └── pony/
│       ├── config.toml      # Language configuration
│       ├── highlights.scm   # Syntax highlighting rules
│       ├── indents.scm      # Auto-indentation rules
│       ├── outline.scm      # Code navigation and outline
│       ├── brackets.scm     # Bracket matching rules
│       ├── textobjects.scm  # Vim text object definitions
│       └── tasks.json       # Corral build tasks
├── LICENSE
└── README.md
```

### Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## Troubleshooting

### "pony-lsp not found on PATH"

If you see this error when opening a `.pony` file:

1. Verify installation: `which pony-lsp`
2. Ensure the binary is in your PATH
3. Restart Zed after modifying PATH
4. Check Zed log for details: `cmd-shift-P` → "zed: open log"

### LSP compilation errors or "go to definition" not working

If the LSP server is running but features don't work:

1. Check the LSP logs: `cmd-shift-P` → "zed: open log"
2. Ensure your project has a `corral.json` file listing local packages

### LSP server not starting

1. Verify pony-lsp is installed and on PATH
2. Check Zed log for pony-lsp errors
3. Ensure you're using pony-lsp v0.61.0 or later

### Extension not loading

1. Check that Rust code compiles: `cargo build --release`
2. Reload extensions in Zed: `cmd-shift-P` → "zed: reload extensions"
3. Check Zed log for extension errors

## Resources

- [Zed Extension Documentation](https://zed.dev/docs/extensions/developing-extensions)
- [Pony Language Server](https://github.com/ponylang/ponyc/tree/main/tools/pony-lsp)
- [Pony Language Tutorial](https://tutorial.ponylang.io/)
- [Pony Language Website](https://www.ponylang.io/)

## License

This project is licensed under the 2-Clause BSD License. See the [LICENSE](LICENSE) file for details.
