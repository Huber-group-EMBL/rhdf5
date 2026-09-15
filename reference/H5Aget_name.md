# Get the name of an HDF5 attribute object

Retrieves the name of the attribute specified by an HDF5 attribute
object.

## Usage

``` r
H5Aget_name(h5attribute)
```

## Arguments

- h5attribute:

  An object of class
  [H5IdComponent](https://huber-group-embl.github.io/rhdf5/reference/H5IdComponent-class.md)
  representing an attribute. Normally created by
  [`H5Aopen()`](https://huber-group-embl.github.io/rhdf5/reference/H5Aopen.md)
  or similar.

## Value

A character vector of length 1 containing the name of the attribute.

## Examples

``` r
h5File <- tempfile(fileext = ".h5")
fid <- H5Fcreate(h5File)
sid <- H5Screate_simple(1)
aid <- H5Acreate(fid, "some_attribute", "H5T_NATIVE_INT", sid)

H5Aget_name(aid)
#> [1] "some_attribute"

H5Aclose(aid)
H5Sclose(sid)
H5Fclose(fid)
file.remove(h5File)
#> [1] TRUE
```
