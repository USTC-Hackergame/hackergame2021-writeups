## p😭q

这 Python 代码写得……可以打出题人了。看一下代码，对音频依序做了如下变换：

1. `melspectrogram` ，从音频生成 Mel 频谱 —— 知道是个变换就行；
2. `power_to_db`，顾名思义，把功率值转换成 dB 为单位；
3. 量化 dB 值到 `range(min_db, max_db + 1, 2))` 这些整数值。

生成 `gif_data` 的那个臭长的 list comprehension 不用管。随便找个音频试试 就能看出，上面三步过后输出的是个 32xN 的频谱，被转换成 N 帧条形图，每个条体现的就是 32 个频段的量化后 dB 值。

量化逆转不了，不用管，肯定会损失一些信息。`power_to_db` 逆过来就 `db_to_power`。关键就是 melspectrogram 这步怎么逆回来。以 `librosa.feature.melspectrogram reverse` 关键字搜索，找到了 `librosa.feature.inverse.mel_to_audio` 这个函数（[文档](https://librosa.org/doc/0.7.0/generated/librosa.feature.inverse.mel_to_audio.html)）。名字非常逼真，参数都直接照搬就行。代码如下：

```python
import imageio
import librosa
import soundfile as sf
import numpy as np

num_freqs = 32
quantize = 2
min_db = -60
max_db = 30
fft_window_size = 2048
frame_step_size = 512
window_function_type = 'hann'
sample_rate = 22050

db_thresholds = np.fromiter(range(min_db, max_db + 1, quantize), dtype='f')

gif = imageio.get_reader("./flag.gif")
wave = np.zeros(0)

spectrogram_frames = []
for idx, gif_frame in enumerate(gif):
    spec_frame = (gif_frame[:, 3::4] < 255).sum(0) // 2
    spectrogram_frames.append(spec_frame)

spectrogram = librosa.db_to_power(np.array(spectrogram_frames).transpose())

assert spectrogram.shape[0] == num_freqs
audio = librosa.feature.inverse.mel_to_audio(
    spectrogram, sample_rate,
    n_fft=fft_window_size, hop_length=frame_step_size, window=window_function_type)

audio /= np.abs(audio).max()
print(audio.shape, audio.min(), audio.max())
sf.write('output.wav', audio, sample_rate)
```

输出的音频质量很差，用人耳重建即可。