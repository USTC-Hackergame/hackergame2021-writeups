import numpy as np
import soundfile as sf

rate = 44100
data = np.random.uniform(-1, 1, size=(rate * 10, 2))

# Write out audio as 24bit PCM WAV
sf.write('stereo_file.wav', data, rate, subtype='PCM_24')
