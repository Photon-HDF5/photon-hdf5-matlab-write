# photon-hdf5-matlab-write
Resources and examples for writing [Photon-HDF5](http://photon-hdf5.org) files in MATLAB.

Create a temporary HDF5 file containing photon-data arrays:

```
n = 1e6; 
timestamps = int64(sort(randi([0 2/10e-9], 1, n)));
detectors = uint8(randi([0 3], 1, n));

h5create('photon_data.h5', '/timestamps', size(timestamps), 'Datatype', 'int64')
h5write('photon_data.h5', '/timestamps', timestamps)
h5create('photon_data.h5', '/detectors', size(detectors), 'Datatype', 'uint8')
h5write('photon_data.h5', '/detectors', detectors)
```

Call [phforge](http://photon-hdf5.github.io/phforge/) to create the Photon-HDF5 file:

```
[status,cmdout] = system('phforge metadata.yaml photon_data.h5 out.h5','-echo');
```
