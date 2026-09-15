# Delete an specified attribute of an HDF5 object

Delete an specified attribute of an HDF5 object

## Usage

``` r
H5Adelete(h5obj, name)
```

## Arguments

- h5obj:

  An object of class
  [H5IdComponent](https://huber-group-embl.github.io/rhdf5/reference/H5IdComponent-class.md)
  representing a H5 object identifier (file, group, or dataset). See
  [`H5Fcreate()`](https://huber-group-embl.github.io/rhdf5/reference/H5Fcreate.md),
  [`H5Fopen()`](https://huber-group-embl.github.io/rhdf5/reference/H5Fopen.md),
  [`H5Gcreate()`](https://huber-group-embl.github.io/rhdf5/reference/H5Gcreate.md),
  [`H5Gopen()`](https://huber-group-embl.github.io/rhdf5/reference/H5Gopen.md),
  [`H5Dcreate()`](https://huber-group-embl.github.io/rhdf5/reference/H5Dcreate.md),
  or
  [`H5Dopen()`](https://huber-group-embl.github.io/rhdf5/reference/H5Dopen.md)
  to create an object of this kind.

- name:

  The name of the attribute (character).

## Examples

``` r
h5File <- tempfile(fileext = ".h5")
fid <- H5Fcreate(h5File)
sid <- H5Screate_simple(1)
aid <- H5Acreate(fid, "some_attribute", "H5T_NATIVE_INT", sid)
H5Aclose(aid)
H5Sclose(sid)

H5Aexists(fid, "some_attribute")
#> [1] TRUE
H5Adelete(fid, "some_attribute")
#> [1] 0
H5Aexists(fid, "some_attribute")
#> [1] FALSE

H5Fclose(fid)
file.remove(h5File)
#> [1] TRUE
```
