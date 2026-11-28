# Add the Zstandard (ZSTD) filter to the chunk processing pipeline.

Add the Zstandard (ZSTD) filter to the chunk processing pipeline.

## Usage

``` r
H5Pset_zstd(h5plist, level = 3L)
```

## Arguments

- h5plist:

  Object of class
  [H5IdComponent](https://huber-group-embl.github.io/rhdf5/reference/H5IdComponent-class.md)
  representing a dataset creation property list.

- level:

  Compression level to be used by the ZSTD algorithm. Must be an integer
  between 0 (default) and 22. When 0, ZSTD uses its own default, which
  is currently 3.

## Examples

``` r
plist <- H5Pcreate("H5P_DATASET_CREATE")
H5Pset_chunk(plist, c(10, 10))
H5Pset_zstd(plist, level = 5)
H5Pclose(plist)
```
