# Zed Pony

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

- [x] Syntax highlighting
- [ ] Code formatting
- [ ] Language Server Protocol (LSP) integration
- [ ] Snippets and completions
- [ ] Documentation on hover
- [ ] Go to definition
- [ ] Error diagnostics

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

## Development

### Prerequisites

- [Zed editor](https://zed.dev)
- [Pony compiler](https://www.ponylang.io/) (optional, for testing Pony code)

### Building

This extension is configuration-only and doesn't require building. It uses the tree-sitter-pony grammar for syntax highlighting, which is automatically fetched and compiled by Zed when you install the extension.

### Project Structure

```
pony-zed-extension/
├── extension.toml      # Extension metadata and grammar registration
├── languages/          # Language definitions
│   └── pony/
│       ├── config.toml      # Language configuration
│       └── highlights.scm   # Syntax highlighting rules
├── LICENSE
└── README.md
```

### Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## Resources

- [Zed Extension Documentation](https://zed.dev/docs/extensions/developing-extensions)
- [Pony Language Tutorial](https://tutorial.ponylang.io/)
- [Pony Language Website](https://www.ponylang.io/)
- [Pony GitHub Repository](https://github.com/ponylang/ponyc)

## License

This project is licensed under the 3-Clause BSD License. See the [LICENSE](LICENSE) file for details.
