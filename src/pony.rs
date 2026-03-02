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
        let server_path = LspSettings::for_worktree("pony-lsp", worktree)
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

        Ok(zed::Command {
            command: server_path,
            args: vec!["--stdio".to_string()],
            env: worktree.shell_env(),
        })
    }
}

zed::register_extension!(PonyExtension);
