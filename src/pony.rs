use zed_extension_api::{self as zed, settings::LspSettings, Result};
use zed_extension_api::serde_json;

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

    fn language_server_workspace_configuration(
        &mut self,
        _language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<Option<serde_json::Value>> {
        let settings = LspSettings::for_worktree("pony-lsp", worktree)
            .ok()
            .and_then(|s| s.settings);

        Ok(settings.map(|s| {
            // Forward only the LSP-relevant settings, nested under "pony-lsp" to match
            // the VS Code convention for workspace/didChangeConfiguration payloads.
            let config: serde_json::Map<String, serde_json::Value> = ["ponypath", "defines"]
                .iter()
                .filter_map(|&key| s.get(key).map(|v| (key.to_string(), v.clone())))
                .collect();
            serde_json::json!({ "pony-lsp": config })
        }))
    }
}

zed::register_extension!(PonyExtension);
