# Write an R object as an HDF5 attribute

Write an R object as an HDF5 attribute

## Usage

``` r
h5writeAttribute(
  attr,
  h5obj,
  name,
  h5loc,
  encoding = NULL,
  variableLengthString = TRUE,
  asScalar = FALSE,
  checkForNA
)

# S3 method for class 'array'
h5writeAttribute(
  attr,
  h5obj,
  name,
  h5loc,
  encoding = NULL,
  variableLengthString = TRUE,
  asScalar = FALSE,
  checkForNA
)
```

## Arguments

- attr:

  The R object to be written as an HDF5 attribute.

- h5obj:

  Normally an object of class
  [H5IdComponent](https://huber-group-embl.github.io/rhdf5/reference/H5IdComponent-class.md)
  representing a H5 object identifier (file, group, or dataset). See
  [`H5Fcreate()`](https://huber-group-embl.github.io/rhdf5/reference/H5Fcreate.md),
  [`H5Fopen()`](https://huber-group-embl.github.io/rhdf5/reference/H5Fopen.md),
  [`H5Gcreate()`](https://huber-group-embl.github.io/rhdf5/reference/H5Gcreate.md),
  [`H5Gopen()`](https://huber-group-embl.github.io/rhdf5/reference/H5Gopen.md),
  [`H5Dcreate()`](https://huber-group-embl.github.io/rhdf5/reference/H5Dcreate.md),
  or
  [`H5Dopen()`](https://huber-group-embl.github.io/rhdf5/reference/H5Dopen.md)
  to create an object of this kind. This argument can also be given the
  path to an HDF5 file.

- name:

  The name of the attribute to be written.

- h5loc:

  The location of the group or dataset within a file to which the
  attribute should be attached. This argument is only used if the
  `h5obj` argument is the path to an HDF5 file, otherwise it is ignored.

- encoding:

  The encoding of the string data type. Valid options are "ASCII" and
  "UTF-8".

- variableLengthString:

  Whether character vectors should be written as variable-length strings
  into the attributes.

- asScalar:

  Whether length-1 `attr` should be written into a scalar dataspace.

- checkForNA:

  Deprecated. This argument is no longer used and will be removed in a
  future version of rhdf5.

## Examples

``` r
hdf5_file <- "test_nona_simple.h5"
h5createFile(hdf5_file)
h5createGroup(hdf5_file, "group")

values_to_be_written <- as.logical(sample(c(0, 1), 100, replace = TRUE))
h5writeAttribute(
  values_to_be_written,
  h5obj = hdf5_file,
  name = "test",
  h5loc = "/group"
)

h5readAttributes(hdf5_file, name = "/group")
#> $test
#>   [1] FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE  TRUE FALSE
#>  [13] FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE  TRUE FALSE FALSE  TRUE FALSE
#>  [25] FALSE FALSE  TRUE FALSE  TRUE  TRUE FALSE FALSE  TRUE  TRUE  TRUE FALSE
#>  [37] FALSE  TRUE FALSE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE  TRUE
#>  [49] FALSE  TRUE FALSE  TRUE  TRUE  TRUE FALSE FALSE  TRUE  TRUE FALSE  TRUE
#>  [61] FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE  TRUE  TRUE FALSE  TRUE  TRUE
#>  [73]  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE FALSE
#>  [85] FALSE  TRUE  TRUE FALSE FALSE  TRUE  TRUE  TRUE FALSE  TRUE FALSE FALSE
#>  [97]  TRUE  TRUE FALSE  TRUE
#> 
```
