# Write data to an HDF5 attribute

Write data to an HDF5 attribute

## Usage

``` r
H5Awrite(h5attribute, buf)
```

## Arguments

- h5attribute:

  An object of class
  [H5IdComponent](https://huber-group-embl.github.io/rhdf5/reference/H5IdComponent-class.md)
  representing an attribute. Normally created by
  [`H5Aopen()`](https://huber-group-embl.github.io/rhdf5/reference/H5Aopen.md)
  or similar.

- buf:

  The data to be written.

## Examples

``` r
h5File <- tempfile(fileext = ".h5")
fid <- H5Fcreate(h5File)
sid <- H5Screate_simple(1)
aid <- H5Acreate(fid, "some_attribute", "H5T_NATIVE_INT", sid)

H5Awrite(aid, 42L)
H5Aread(aid)
#> [1] 42

H5Aclose(aid)
H5Sclose(sid)
H5Fclose(fid)
file.remove(h5File)
#> [1] TRUE
```
