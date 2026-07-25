//! The `Http` port adapter: VertHawk offline adapter.
//! All network requests return an immediate transport error.

use windhawk_core_ports::{CancelToken, Http, HttpError, HttpRequest, HttpSink};

pub struct WindowsHttp;

impl Http for WindowsHttp {
    fn get(
        &self,
        _request: &HttpRequest,
        cancel: &CancelToken,
        _sink: &mut dyn HttpSink,
    ) -> Result<u16, HttpError> {
        if cancel.is_canceled() {
            return Err(HttpError::Canceled);
        }

        // VertHawk Offline Policy: Disable all network activity
        Err(HttpError::transport("Network connections are disabled in VertHawk", 0))
    }
}
