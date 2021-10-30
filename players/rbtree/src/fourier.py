import numpy
import librosa
from scipy.io import wavfile

freq_maps = list()
freq_file = open('freq.txt', 'r')

for i in range(578):
    line_data = [float(x) * 33 - 52 for x in freq_file.readline().strip().split(' ')]
    freq_maps.append(numpy.array(line_data))

sample_rate = 22050
freq_data = numpy.array(freq_maps).transpose()

sound = librosa.feature.inverse.mel_to_audio(librosa.db_to_power(freq_data))
print(sound)
wavfile.write('a.wav', 22050, sound)
