#' Write an R object as an HDF5 attribute
#'
#' @param attr The R object to be written as an HDF5 attribute.
#' @param h5obj Normally an object of class [H5IdComponent-class] representing a
#'   H5 object identifier (file, group, or dataset). See
#'   [H5Fcreate()], [H5Fopen()], [H5Gcreate()],
#'   [H5Gopen()], [H5Dcreate()], or [H5Dopen()] to
#'   create an object of this kind.  This argument can also be given the path to
#'   an HDF5 file.
#' @param name The name of the attribute to be written.
#' @param h5loc The location of the group or dataset within a file to which the
#'   attribute should be attached. This argument is only used if the
#'   `h5obj` argument is the path to an HDF5 file, otherwise it is ignored.
#' @param encoding The encoding of the string data type. Valid options are
#'   "ASCII" and "UTF-8".
#' @param variableLengthString Whether character vectors should be written as
#'   variable-length strings into the attributes.
#' @param asScalar Whether length-1 `attr` should be written into a scalar
#'   dataspace.
#' @param checkForNA Deprecated. This argument is no longer used and will be
#'   removed in a future version of rhdf5.
#' @name h5_writeAttribute
#'
#' @export
#'
#' @examples
#' hdf5_file <- "test_nona_simple.h5"
#' h5createFile(hdf5_file)
#' h5createGroup(hdf5_file, "group")
#'
#' values_to_be_written <- as.logical(sample(c(0, 1), 100, replace = TRUE))
#' h5writeAttribute(
#'   values_to_be_written,
#'   h5obj = hdf5_file,
#'   name = "test",
#'   h5loc = "/group"
#' )
#'
#' h5readAttributes(hdf5_file, name = "/group")
h5writeAttribute <- function(
  attr,
  h5obj,
  name,
  h5loc,
  encoding = NULL,
  variableLengthString = TRUE,
  asScalar = FALSE,
  checkForNA
) {
  if (!missing(checkForNA)) {
    warning(
      "The argument 'checkForNA' is deprecated ",
      "and will be removed in a future version of rhdf5.",
      call. = FALSE
    )
  }
  if (is(attr, "H5IdComponent")) {
    res <- h5writeAttribute.array(attr, h5obj, name, asScalar = TRUE)
  } else {
    res <- UseMethod("h5writeAttribute")
  }
  invisible(res)
}

#' @export
h5writeAttribute.integer <- function(...) {
  h5writeAttribute.array(...)
}
#' @export
h5writeAttribute.double <- function(...) {
  h5writeAttribute.array(...)
}
#' @export
h5writeAttribute.logical <- function(...) {
  h5writeAttribute.array(...)
}
#' @export
h5writeAttribute.character <- function(...) {
  h5writeAttribute.array(...)
}
#' @export
h5writeAttribute.default <- function(attr, h5obj, name, ...) {
  warning(
    "No function found to write attribute of class '",
    class(attr),
    "'. Attribute '",
    name,
    "' is not written to hdf5-file."
  )
}

#' @rdname h5_writeAttribute
#'
#' @export
h5writeAttribute.array <- function(
  attr,
  h5obj,
  name,
  h5loc,
  encoding = NULL,
  variableLengthString = TRUE,
  asScalar = FALSE,
  checkForNA
) {
  if (is.character(h5obj) && file.exists(h5obj)) {
    fid <- H5Fopen(h5obj, flags = "H5F_ACC_RDWR")
    on.exit(H5Fclose(fid))
    h5obj <- H5Oopen(h5loc = fid, name = h5loc)
    on.exit(H5Oclose(h5obj), add = TRUE)
  } else {
    h5checktype(h5obj, "object")
  }

  if (asScalar) {
    if (length(attr) != 1L) {
      stop("cannot use 'asScalar=TRUE' when 'length(attr) > 1'")
    }
    dims <- NULL
  } else {
    dims <- dim(attr) %||% length(attr)
  }

  size <- NULL
  if (storage.mode(attr) == "character" && !variableLengthString) {
    size <- max(nchar(attr, type = "bytes")) + 1
  }

  if (H5Aexists(h5obj, name)) {
    H5Adelete(h5obj, name)
  }
  storagemode <- storage.mode(attr)
  tid <- NULL
  if (storagemode == "S4" && is(attr, "H5IdComponent")) {
    storagemode <- "H5IdComponent"
  }

  h5createAttribute(
    h5obj,
    name,
    dims = dims,
    storage.mode = storagemode,
    size = size,
    H5type = tid,
    encoding = match.arg(encoding, choices = c("ASCII", "UTF-8", "UTF8"))
  )
  h5attr <- H5Aopen(h5obj, name)
  on.exit(H5Aclose(h5attr), add = TRUE)

  res <- H5Awrite(h5attr, attr)

  invisible(res)
}
