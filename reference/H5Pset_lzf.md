# Add the LZF filter to the chunk processing pipeline.

Add the LZF filter to the chunk processing pipeline.

## Usage

``` r
H5Pset_lzf(h5plist, h5tid)
```

## Arguments

- h5plist:

  Object of class
  [H5IdComponent](https://huber-group-embl.github.io/rhdf5/reference/H5IdComponent-class.md)
  representing a dataset creation property list.

- h5tid:

  Deprecated. This argument is not used and will be ignored.

## Examples

``` r
plist <- H5Pcreate("H5P_DATASET_CREATE")
H5Pset_chunk(plist, c(10, 10))
H5Pset_lzf(plist)
H5Pclose(plist)
```
