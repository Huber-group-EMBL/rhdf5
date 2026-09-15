# Get a copy of the attribute dataspace

Get a copy of the attribute dataspace

## Usage

``` r
H5Aget_space(h5attribute)
```

## Arguments

- h5attribute:

  An object of class
  [H5IdComponent](https://huber-group-embl.github.io/rhdf5/reference/H5IdComponent-class.md)
  representing an attribute. Normally created by
  [`H5Aopen()`](https://huber-group-embl.github.io/rhdf5/reference/H5Aopen.md)
  or similar.

## Value

Returns an object of class
[H5IdComponent](https://huber-group-embl.github.io/rhdf5/reference/H5IdComponent-class.md)
representing a H5 dataspace identifier

## Examples

``` r
h5File <- tempfile(fileext = ".h5")
fid <- H5Fcreate(h5File)
sid <- H5Screate_simple(5)
aid <- H5Acreate(fid, "some_attribute", "H5T_NATIVE_INT", sid)

sid2 <- H5Aget_space(aid)
H5Sget_simple_extent_dims(sid2)
#> $rank
#> [1] 1
#> 
#> $size
#> [1] 5
#> 
#> $maxsize
#> [1] 5
#> 

H5Sclose(sid2)
H5Aclose(aid)
H5Sclose(sid)
H5Fclose(fid)
file.remove(h5File)
#> [1] TRUE
```
