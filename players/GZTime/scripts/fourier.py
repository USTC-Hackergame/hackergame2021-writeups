from PIL import Image
import numpy as np
import librosa
import soundfile

BAR_NUM = 32
BAR_POS = [3 + i * 4 for i in range(BAR_NUM)]

res = []

for i in range(1, 588):
    line = np.zeros((32), dtype=np.uint32)
    img = Image.open(f'frame/{i:04}.png')
    for height in range(92):
        row = [1 if img.getpixel((i, height))[1] == 0 else 0 for i in BAR_POS]
        line = line + np.array(row)
    res.append(line)

sample_rate = 22050
frame_step_size = 512
min_db = -60

spectrogram = np.array(res).transpose() + min_db
spectrogram = librosa.db_to_power(spectrogram)
audio = librosa.feature.inverse.mel_to_audio(spectrogram, hop_length=frame_step_size)
soundfile.write('result.wav', audio, sample_rate)
