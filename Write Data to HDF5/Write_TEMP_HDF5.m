%% Write TEMP HDF5 file
%Insert experimental data on right side

timestamps = int64(sort(timestamps));
detectors = uint8(detectors);

h5create('photon_data.h5', '/timestamps', size(timestamps), 'Datatype', 'int64')
h5write('photon_data.h5', '/timestamps', timestamps)
h5create('photon_data.h5','/detectors', size(detectors), 'Datatype', 'uint8')
h5write('photon_data.h5', '/detectors', detectors)

[status,cmdout] = system('phforge metadata.yaml photon_data.h5 out.h5','-echo')