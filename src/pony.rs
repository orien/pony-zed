use zed_extension_api::{self as zed, settings::LspSettings, Result};

struct PonyExtension;

impl zed::Extension for PonyExtension {
    fn new() -> Self {
        Self
    }

    fn language_server_command(
        &mut self,
        _language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        // Check for custom pony-lsp path in settings first
        let server_path = LspSettings::for_worktree("pony-language-server", worktree)
            .ok()
            .and_then(|settings| settings.settings)
            .and_then(|settings_value| {
                settings_value
                    .get("executable")
                    .and_then(|v| v.as_str())
                    .filter(|path| !path.is_empty())
                    .map(|path| path.to_string())
            });

        // Fall back to PATH lookup if not configured
        let server_path = match server_path {
            Some(path) => path,
            None => worktree.which("pony-lsp").ok_or_else(|| {
                "pony-lsp not found on PATH. \
                    Please install from https://github.com/ponylang/ponyc"
                    .to_string()
            })?,
        };

        // Get the shell environment as a starting point
        let mut env = worktree.shell_env();

        // Build PONYPATH: project_root:stdlib_path (if configured)
        let mut pony_path_parts = Vec::new();

        // Add project root to PONYPATH
        pony_path_parts.push(worktree.root_path().to_string());

        // Read pony_stdlib_path from extension settings
        if let Ok(settings) = LspSettings::for_worktree("pony-language-server", worktree) {
            if let Some(settings_value) = settings.settings {
                if let Some(stdlib_path) = settings_value.get("pony_stdlib_path").and_then(|v| v.as_str()) {
                    if !stdlib_path.is_empty() {
                        pony_path_parts.push(stdlib_path.to_string());
                    }
                }
            }
        }

        // Set PONYPATH environment variable
        env.push(("PONYPATH".to_string(), pony_path_parts.join(":")));

        Ok(zed::Command {
            command: server_path,
            args: vec!["--stdio".to_string()],
            env,
        })
    }
}

zed::register_extension!(PonyExtension);
