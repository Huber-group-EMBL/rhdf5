# Add the BLOSC filter to the chunk processing pipeline.

Add the BLOSC filter to the chunk processing pipeline.

## Usage

``` r
H5Pset_blosc(h5plist, h5tid, method = 1L, level = 6L, shuffle = TRUE)
```

## Arguments

- h5plist:

  Object of class
  [H5IdComponent](https://huber-group-embl.github.io/rhdf5/reference/H5IdComponent-class.md)
  representing a dataset creation property list.

- h5tid:

  HDF5 data type id

- method:

  Integer defining which of the compression algorithms provided by BLOSC
  should be used. (See the details section for the mapping between
  integers and algorithms).

- level:

  Compression level to be used by the selected algorithm.

- shuffle:

  Logical defining whether the bit-shuffle algorithm should be used
  prior to compression. This makes use of the shuffle implementation
  provide by BLOSC, rather than the HDF5 version.

## Examples

``` r
tid <- H5Tcopy("H5T_NATIVE_DOUBLE")
plist <- H5Pcreate("H5P_DATASET_CREATE")
H5Pset_chunk(plist, c(10, 10))
H5Pset_blosc(plist, tid, method = 1, level = 6, shuffle = TRUE)
H5Pclose(plist)
```
