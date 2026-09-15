# Close an HDF5 attribute

Close an HDF5 attribute

## Usage

``` r
H5Aclose(h5attribute)
```

## Arguments

- h5attribute:

  An object of class
  [H5IdComponent](https://huber-group-embl.github.io/rhdf5/reference/H5IdComponent-class.md)
  representing a the attribute to be closed. Normally created by
  [`H5Aopen()`](https://huber-group-embl.github.io/rhdf5/reference/H5Aopen.md)
  or similar.

## See also

[`H5Aopen()`](https://huber-group-embl.github.io/rhdf5/reference/H5Aopen.md)

## Examples

``` r
h5File <- tempfile(fileext = ".h5")
fid <- H5Fcreate(h5File)
sid <- H5Screate_simple(1)
aid <- H5Acreate(fid, "some_attribute", "H5T_NATIVE_INT", sid)

H5Aclose(aid)

H5Sclose(sid)
H5Fclose(fid)
file.remove(h5File)
#> [1] TRUE
```
