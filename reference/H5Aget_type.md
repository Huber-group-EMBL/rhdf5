# Get a copy of the attribute datatype

Get a copy of the attribute datatype

## Usage

``` r
H5Aget_type(h5attribute)
```

## Arguments

- h5attribute:

  An object of class
  [H5IdComponent](https://huber-group-embl.github.io/rhdf5/reference/H5IdComponent-class.md)
  representing an attribute. Normally created by
  [`H5Aopen()`](https://huber-group-embl.github.io/rhdf5/reference/H5Aopen.md)
  or similar.

## Examples

``` r
h5File <- tempfile(fileext = ".h5")
fid <- H5Fcreate(h5File)
sid <- H5Screate_simple(1)
aid <- H5Acreate(fid, "some_attribute", "H5T_NATIVE_INT", sid)

tid <- H5Aget_type(aid)
H5Tget_class(tid)
#> [1] "H5T_INTEGER"

H5Aclose(aid)
H5Sclose(sid)
H5Fclose(fid)
file.remove(h5File)
#> [1] TRUE
```
