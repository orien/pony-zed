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

- Syntax highlighting
- Auto-indentation
- Code navigation (outline panel and breadcrumbs)
- Language Server Protocol (LSP) integration
- Go to definition

**Note:** The Pony LSP server (v0.2.2) is still in early development. Additional features like hover documentation, code completion, find references, and rename are not yet implemented in the server itself.

## Installation

### From Zed Extensions

Once published, you'll be able to install this extension directly from the Zed extensions panel:

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

### Language Server Installation (Required for LSP Features)

To enable LSP features, you must install `pony-lsp`:

```bash
# Clone and build pony-language-server
git clone https://github.com/ponylang/pony-language-server
cd pony-language-server
make language_server

# The binary will be at: build/release/pony-lsp
# Add it to your PATH, for example:
export PATH="$PATH:$(pwd)/build/release"
```

Verify installation:
```bash
which pony-lsp
```

**Note:** The language server must be built from source as there are no prebuilt binaries available.

## Configuration

### Pony Standard Library Path

The extension needs to know where to find the Pony standard library packages. Add this to your Zed `settings.json`:

1. Open Zed settings: `cmd-,` (macOS) or `ctrl-,` (Linux/Windows)
2. Add the following configuration:

```json
{
  "lsp": {
    "pony-language-server": {
      "settings": {
        "pony_stdlib_path": "/opt/homebrew/Cellar/ponyc/0.60.4/packages"
      }
    }
  }
}
```

**Finding your stdlib path:**

On macOS/Linux, run this command to find the correct path:

```bash
readlink -f $(which ponyc) | sed 's|/bin/ponyc|/packages|'
```

Or manually locate it based on your Pony installation:
- **Homebrew (Apple Silicon)**: `/opt/homebrew/Cellar/ponyc/VERSION/packages`
- **Homebrew (Intel Mac)**: `/usr/local/Cellar/ponyc/VERSION/packages`
- **Linux**: `/usr/lib/pony` or `/usr/share/ponyc/packages`

Replace `VERSION` with your installed Pony version (e.g., `0.60.4`).

## Development

### Prerequisites

- [Zed editor](https://zed.dev)
- [Rust](https://rustup.rs/) (required for building the extension)
- [Pony compiler](https://www.ponylang.io/) (required for building pony-language-server)
- [pony-language-server](https://github.com/ponylang/pony-language-server) (optional, enables LSP features)

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
│   └── lib.rs          # LSP integration code
├── languages/          # Language definitions
│   └── pony/
│       ├── config.toml      # Language configuration
│       ├── highlights.scm   # Syntax highlighting rules
│       ├── indents.scm      # Auto-indentation rules
│       └── outline.scm      # Code navigation and outline
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

1. Ensure you've configured `pony_stdlib_path` in your Zed settings (see Configuration section above)
2. Verify the stdlib path exists: `ls /path/to/your/stdlib/builtin`
3. Check the LSP logs: `cmd-shift-P` → "zed: open log"
4. Look for "initial PONYPATH:" in the logs - it should include both your project and stdlib paths
5. Ensure your project has a `corral.json` file listing local packages

### LSP server not starting

1. Verify pony-lsp is installed and on PATH
2. Check Zed log for pony-lsp errors
3. Ensure you're using pony-language-server v0.2.2 or later

### Extension not loading

1. Check that Rust code compiles: `cargo build --release`
2. Reload extensions in Zed: `cmd-shift-P` → "zed: reload extensions"
3. Check Zed log for extension errors

## Resources

- [Zed Extension Documentation](https://zed.dev/docs/extensions/developing-extensions)
- [Pony Language Server](https://github.com/ponylang/pony-language-server)
- [Pony Language Tutorial](https://tutorial.ponylang.io/)
- [Pony Language Website](https://www.ponylang.io/)
- [Pony GitHub Repository](https://github.com/ponylang/ponyc)

## License

This project is licensed under the 3-Clause BSD License. See the [LICENSE](LICENSE) file for details.
