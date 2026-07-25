//! `services::update`: VertHawk update stubs (self-update disabled).

use std::sync::Arc;

use serde_json::Value;

use crate::error::CoreError;
use crate::runtime::PreparedOp;
use crate::session::SessionInner;

/// `startUpdate`: disabled in VertHawk.
pub fn prepare_start_update(
    _session: &Arc<SessionInner>,
    _params: Value,
) -> Result<PreparedOp, CoreError> {
    Err(CoreError::canceled())
}

/// `startInstallDevTools`: disabled in VertHawk.
pub fn prepare_start_install_devtools(
    _session: &Arc<SessionInner>,
    _params: Value,
) -> Result<PreparedOp, CoreError> {
    Err(CoreError::canceled())
}
