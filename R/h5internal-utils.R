#' Wrap the result of a `.Call()` used to create/open an HDF5 identifier
#'
#' @param id The identifier value returned from `.Call()`.
#' @param native The `native` value to store on the resulting `H5IdComponent`.
#' @param what Character string describing the action that failed, used to
#'   build the failure message.
#'
#' @returns Either an object of class `H5IdComponent`, or `FALSE` if `id`
#'   was not valid (with a message emitted as a side effect).
#'
#' @keywords internal
#' @noRd
.wrapH5Id <- function(id, native, what) {
  if (id > 0) {
    new("H5IdComponent", ID = id, native = native)
  } else {
    message("HDF5: unable to ", what)
    FALSE
  }
}
