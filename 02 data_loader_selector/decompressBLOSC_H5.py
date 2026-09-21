import h5py
import hdf5plugin  # this enables BLOSC support
import numpy as np

input_file = 'events.h5'
output_file = 'events_uncompressed.h5'

with h5py.File(input_file, 'r') as f_in:
    with h5py.File(output_file, 'w') as f_out:
        events_group = f_out.create_group('/events')
        for name in f_in['/events']:
            print(f"Decompressing dataset: {name}")
            data = f_in['/events'][name][()]  # fully read the dataset
            events_group.create_dataset(name, data=data, compression=None)
