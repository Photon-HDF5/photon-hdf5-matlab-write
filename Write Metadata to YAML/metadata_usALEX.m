%% Madatory Metadata

%Mandatory Fields
filename =             filename; %Metadata YAML filename e.g. 'metadata.yaml'
description =          description;
num_pixels =           num_pixels;
num_spots =            num_spots;
num_spectral_ch =      num_spectral_ch;
num_split_ch =         num_split_ch;
modulated_excitation = modulated_excitation;
if modulated_excitation
    modulated_excitation = 'True';
else
    modulated_excitation = 'False';
end
lifetime =             lifetime;
if lifetime
    lifetime = 'True';
else
    lifetime = 'False';
end

%% Format/Write Mandatory fields to YAML file

formatSpec = ['description: %s \n'...
'\n'...
'setup: \n'...
'    num_pixels: %hd                # number single-pixel detectors \n'...
'    num_spots: %hd                 # number of confocal excitation spots \n'...
'    num_spectral_ch: %hd           # 2 for donor and acceptor detection \n'...
'    num_polarization_ch: %hd       # 1 = no polarization selection \n'...
'    num_split_ch: %hd              # 1 = no beam splitting \n'...
'    modulated_excitation: %s   # us-ALEX alternation requires True here \n'...
'    lifetime: %s               # False = no TCSPC in detection \n'...
'\n'];

fileID = fopen(filename,'w');
fprintf(fileID,formatSpec,description,num_pixels,num_spots,num_spectral_ch,...
        num_polarization_ch,num_split_ch,modulated_excitation,lifetime);
%fclose(fileID);


%% Optional fields (Comment out if not used!)
%assumes two wavelengths

excitation_wavelengths = excitation_wavelengths;
excitation_cw =          excitation_cw;

if excitation_cw(1,1)
    excitation_cwa = 'True';
else
    excitation_cwa = 'False';
end
if excitation_cw(1,2)
    excitation_cwb = 'True';
else
    excitation_cwb = 'False';
end
detection_wavelengths = detection_wavelengths;

%% Format/Write Optional fields to YAML file (Comment out if not used!)
formatSpec = [...
'    excitation_wavelengths: [%g,%g]  # List of excitation wavelenghts \n'...
'    excitation_cw: [%s,%s]               # List of booleans, True if wavelength is CW \n'...
'    detection_wavelengths: [%g, %g]   # Center wavelength for each for detection ch \n'...
'\n'];

fprintf(fileID,formatSpec,excitation_wavelengths(1,1),excitation_wavelengths(1,2),...
        excitation_cwa,excitation_cwb,detection_wavelengths(1),...
        detection_wavelengths(2));
    
%% Sample Metadata

sample_name = sample_name;
buffer_name = buffer_name;
dye_names =   dye_names;

%% Write Sample Metadata to YAML file

formatSpec = ['sample: \n'...
'  sample_name: %s \n'...
'  buffer_name: %s \n' ...
'  dye_names: ''%s''   # Comma separates names of fluorophores \n'...
'\n'];

fprintf(fileID,formatSpec,sample_name,buffer_name,dye_names);


%% Identity Metadata

author =             author;
author_affiliation = author_affiliation;

%% Format/Write Identity Metadata to YAML file

formatSpec = ['identity: \n'...
'    author: %s \n'...
'    author_affiliation: %s \n'...
'\n'];

fprintf(fileID,formatSpec, author, author_affiliation);
    
%% Provenance Metadata

expfilename = expfilename; %Experimental Filename e.g. 'photon_data.hdf5'
software =    software;



%% Format/Write Provenance Metadata to YAML file

formatSpec = ['provenance: \n'...
'    filename: ''%s'' \n'...
'    software: %s \n'...
'\n'];

fprintf(fileID,formatSpec,expfilename,software);

%% Photon Data Metadata

timestamps_unit =         timestamps_unit;

measurement_type =        measurement_type;
alex_period =             alex_period;
alex_offset =             alex_offset;
alex_excitation_period1 = alex_excitation_period1;
alex_excitation_period2 = alex_excitation_period2;

spectral_ch1 =            spectral_ch1;
spectral_ch2 =            spectral_ch2;

%% Format/Write Photon Data Metadata to YAML file

formatSpec = ['photon_data: \n'...
'    timestamps_specs: \n'...
'        timestamps_unit: %g  # 10 ns \n'...
'    measurement_specs: \n'...
'        measurement_type: %s \n'...
'        alex_period: %hd \n'...
'        alex_offset: %g \n'...
'        alex_excitation_period1: [%hd,%hd] \n'...
'        alex_excitation_period2: [%hd,%hd] \n'...
'\n'...
'        detectors_specs: \n'...
'            spectral_ch1: [%hd]  # list of donors detector IDs \n'...
'            spectral_ch2: [%hd]  # list of acceptors detector IDs'];

fprintf(fileID,formatSpec,timestamps_unit,measurement_type,...
        alex_period,alex_offset,alex_excitation_period1(1,1),...
        alex_excitation_period1(1,2),alex_excitation_period2(1,1),...
        alex_excitation_period2(1,2),spectral_ch1,spectral_ch2);

%% Close file
fclose(fileID);