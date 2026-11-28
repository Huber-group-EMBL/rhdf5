# Add the SZIP compression filter to the chunk processing pipeline.

Add the SZIP compression filter to the chunk processing pipeline.

## Usage

``` r
H5Pset_szip(h5plist, options_mask, pixels_per_block)
```

## Arguments

- h5plist:

  Object of class
  [H5IdComponent](https://huber-group-embl.github.io/rhdf5/reference/H5IdComponent-class.md)
  representing a dataset creation property list.

- options_mask, pixels_per_block:

  Integer vectors of length 1, setting parameters of the SZIP algorithm.
  See the HDF5 documentation for more details.

## References

<https://support.hdfgroup.org/documentation/hdf5/latest/_h5_d__u_g.html#subsubsec_dataset_filters_szip>
