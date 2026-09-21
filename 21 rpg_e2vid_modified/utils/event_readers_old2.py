import pandas as pd
import zipfile
from os.path import splitext
import numpy as np
from .timers import Timer


class FixedSizeEventReader:
    """
    Reads events from a '.txt' or '.zip' file, and packages the events into
    non-overlapping event windows, each containing a fixed number of events.
    """

    def __init__(self, path_to_event_file, num_events=10000, start_index=0):
        print('Will use fixed size event windows with {} events'.format(num_events))
        print('Output frame rate: variable')
        self.iterator = pd.read_csv(path_to_event_file, delim_whitespace=True, header=None,
                                    names=['t', 'x', 'y', 'pol'],
                                    dtype={'t': np.float64, 'x': np.int16, 'y': np.int16, 'pol': np.int16},
                                    engine='c',
                                    skiprows=start_index + 1, chunksize=num_events, nrows=None, memory_map=True)

    def __iter__(self):
        return self

    def __next__(self):
        with Timer('Reading event window from file'):
            event_window = self.iterator.__next__().values
        return event_window


class FixedDurationEventReader:
    """
    Reads events from a '.txt' or '.zip' file, and packages the events into
    non-overlapping event windows, each of a fixed duration.

    **Note**: This reader is much slower than the FixedSizeEventReader.
              The reason is that the latter can use Pandas' very efficient cunk-based reading scheme implemented in C.
    """

    def __init__(self, path_to_event_file, duration_ms=50.0, start_index=0):
        print('Will use fixed duration event windows of size {:.2f} ms'.format(duration_ms))
        print('Output frame rate: {:.1f} Hz'.format(1000.0 / duration_ms))
        file_extension = splitext(path_to_event_file)[1]
        assert(file_extension in ['.txt', '.zip'])
        self.is_zip_file = (file_extension == '.zip')

        if self.is_zip_file:  # '.zip'
            self.zip_file = zipfile.ZipFile(path_to_event_file)
            files_in_archive = self.zip_file.namelist()
            assert(len(files_in_archive) == 1)  # make sure there is only one text file in the archive
            self.event_file = self.zip_file.open(files_in_archive[0], 'r')
        else:
            self.event_file = open(path_to_event_file, 'r')

        # ignore header + the first start_index lines
        for i in range(1 + start_index):
            self.event_file.readline()

        self.last_stamp = None
        self.duration_s = duration_ms / 1000.0

    def __iter__(self):
        return self

    def __del__(self):
        if self.is_zip_file:
            self.zip_file.close()

        self.event_file.close()

    def __next__(self):
        event_list = []

        if not hasattr(self, 'current_time'):
            # initialize current_time with first event
            line = self.event_file.readline()
            if not line:
                raise StopIteration
            if self.is_zip_file:
                line = line.decode("utf-8")
            t, x, y, pol = line.split(' ')
            t = float(t)
            self.current_time = t
            self.next_time = self.current_time + self.duration_s
            event_list.append([t, int(x), int(y), int(pol)])

        if hasattr(self, 'next_event') and self.next_event is not None:
            t, x, y, pol = self.next_event
            if t < self.next_time:
                event_list.append([t, x, y, pol])
                self.next_event = None

        for line in self.event_file:
            if self.is_zip_file:
                line = line.decode("utf-8")
            t, x, y, pol = line.split(' ')
            t = float(t)
            x, y, pol = int(x), int(y), int(pol)
            if t < self.next_time:
                event_list.append([t, x, y, pol])
            else:
                self.next_event = [t, x, y, pol]
                break

        # empty array if no events
        window = np.array(event_list) if event_list else np.zeros((0, 4))

        # advance time for next window
        self.current_time = self.next_time
        self.next_time += self.duration_s

        return window
