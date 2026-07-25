//! `services::repo`: VertHawk repository stubs (online repository disabled).

use std::sync::Arc;

use serde_json::Value;

use crate::error::CoreError;
use crate::runtime::PreparedOp;
use crate::session::SessionInner;

/// The repository mods folder URL: disabled in VertHawk.
pub(crate) fn mods_folder_url(_session: &SessionInner) -> String {
    String::new()
}

pub fn prepare_fetch_catalog(
    _session: &Arc<SessionInner>,
    _params: Value,
) -> Result<PreparedOp, CoreError> {
    Err(CoreError::repo_unreachable(
        "Mod repository functionality has been permanently removed from VertHawk.",
        "",
    ))
}

pub fn prepare_fetch_repo_mod_source(
    _session: &Arc<SessionInner>,
    _params: Value,
) -> Result<PreparedOp, CoreError> {
    Err(CoreError::repo_unreachable(
        "Mod repository fetching functionality has been permanently removed from VertHawk.",
        "",
    ))
}

pub fn prepare_fetch_mod_versions(
    _session: &Arc<SessionInner>,
    _params: Value,
) -> Result<PreparedOp, CoreError> {
    Err(CoreError::repo_unreachable(
        "Mod repository versioning functionality has been permanently removed from VertHawk.",
        "",
    ))
}
