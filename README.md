# photon-hdf5-matlab-write
Resources and examples for writing [Photon-HDF5](http://photon-hdf5.org) files in MATLAB.

Example MATLAB to save Photon-HDF5 files using phforge (to learn more about phforge, please visit: http:// photon-hdf5.github.io/phforge/).

This repository contains 5 MATLAB scripts to help create YAML and HDF5 necessary for phforge:
-Write TEMP YAML File (for nsALEX,smFRET,usALEX, and Minimal required data)
-Write TEMP DATA HDF5 File and write HDF5 with phconvert

**Initialization of phforge in MATLAB**

In order to use phforge within matlab, the PATH must be added to MATLAB. After phforge has been installed and the PATH has been updated (either by "source ~/.bash_profile" or restarting computer), the easiest way to find the PATH for phforge is the command: `which phforge`

![Find_Path](Figures/Find_Path.png?raw=true "Find_Path;")

The highlighted text is the PATH needed for MATLAB.

To add PATH to MATLAB, simply use the following lines of code within MATLAB:

```

PATH = getenv('PATH');
setenv('PATH', [PATH ':/Copy/Path/Here/']);

```

After the PATH has been added, phforge can be called with the 'system' MATLAB command.


**Create a temporary HDF5 file containing photon-data arrays:**

The following script will allow creation of a TEMP DATA HDF5 file

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

This version should be compatible on Mac 10.9+, Linux, and Windows 7+ with MATLAB 2013a+.
