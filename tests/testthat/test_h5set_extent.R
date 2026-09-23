############################################################
context("h5set_extent")
############################################################

## output file name
h5File <- withr::local_tempfile(pattern = "ex_set_extent_", fileext = ".h5")

## populate an example file
D <- 1:20
h5createFile(h5File)
h5createDataset(
  file = h5File,
  dataset = "foo",
  dims = c(1, length(D)),
  maxdims = c(4, length(D))
)
h5write(obj = D, file = h5File, name = "foo")

test_that("Dimensions as expected", {
  expect_shape(h5read(h5File, name = "foo"), dim = c(1L, length(D)))
})

test_that("Changing dataset dimensions", {
  expect_true(h5set_extent(
    file = h5File,
    dataset = "foo",
    dims = c(2, length(D))
  ))
  expect_shape(h5read(h5File, name = "foo"), dim = c(2L, length(D)))
})

test_that("Fail if given a group", {
  expect_true(h5createGroup(file = h5File, group = "baa"))
  expect_error(
    h5set_extent(file = h5File, dataset = "baa", dims = c(1, 1)),
    regexp = "is not a dataset\\.$"
  )
})

test_that("Fail if missing", {
  expect_error(
    h5set_extent(file = h5File, dataset = "missing", dims = c(1, 1)),
    regexp = "does not exist in this HDF5 file.",
    fixed = TRUE
  )
})

test_that("Changing extent via dataset handle", {
  fid <- H5Fopen(h5File)
  on.exit(H5Fclose(fid))
  did <- H5Dopen(fid, "foo")
  on.exit(H5Dclose(did), add = TRUE)

  expect_true(h5set_extent(
    file = h5File,
    dataset = did,
    dims = c(3, length(D))
  ))
  expect_shape(h5read(h5File, name = "foo"), dim = c(3L, length(D)))
})

test_that("h5set_extent() rejects non-chunked dataset handle", {
  h5createDataset(
    file = h5File,
    dataset = "unchunked",
    dims = c(1, 4),
    chunk = NULL,
    level = 0
  )
  fid <- H5Fopen(h5File)
  on.exit(H5Fclose(fid))
  did <- H5Dopen(fid, "unchunked")
  on.exit(H5Dclose(did), add = TRUE)

  expect_error(
    h5set_extent(dataset = did, dims = c(2, 4)),
    "is not chunked"
  ) |>
    expect_no_warning()
})
