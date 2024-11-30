# p😭q

题解作者：[曾明亮](https://github.com/mlzeng)

出题人、验题人、文案设计等：见 [Hackergame 2021 幕后工作人员](../../credits.pdf)。

## 题目描述

- 题目分类：general

- 题目分值：400

- 题目链接：[src/fourier.zip](src/fourier.zip)

学会傅里叶的一瞬间，悔恨的泪水流了下来。

当我看到音频播放器中跳动的频谱动画，月明星稀的夜晚，深邃的银河，只有天使在浅吟低唱，复杂的情感于我眼中溢出，像是沉入了雾里朦胧的海一样的温柔。

这一刻我才知道，耳机音响也就图一乐，真听音乐还得靠眼睛。

![fourier.gif](src/fourier.gif)

（注意：flag 花括号内是一个 12 位整数，由 0-9 数位组成，没有其它字符。）

**点击下面按钮下载源代码与图片**

## 题解

如果是顶尖 HiFi 玩家，可以直接看频谱图得到答案。如果没有这样的天分，也可以用频谱图还原音频信号，然后听音频得到答案。

根据频谱图生成代码可以看出频谱图数据是使用 librosa 计算得到的。根据 librosa 文档 [librosa.feature.melspectrogram](https://librosa.org/doc/main/generated/librosa.feature.melspectrogram.html) 和傅里叶相关资料理解音频信号处理过程：

* 短时距傅里叶变换：使用汉明窗，滑动窗口长度为 2048 个采样点，每帧窗口移动 512 个采样点。完成变换后，对结果的所有复数值取绝对值平方（即丢弃每个频率上的相位信息，仅保留功率信息）。
* 梅尔滤波：将短时距傅里叶变换得到的 1025 个频率上的功率信息经过梅尔过滤矩阵 [librosa.filters.mel](https://librosa.org/doc/main/generated/librosa.filters.mel.html) 线性变换，（有损）压缩合并到 32 个频率上，变成梅尔频谱。
* 将功率值转换为分贝值（并将数值量化到 2 的整数倍）

那么只要从频谱图 GIF 中解析出频谱图数据，根据处理过程逆变换还原音频信号数据即可：

* 将分贝值转换为功率值

* 梅尔滤波逆变换：虽然梅尔过滤矩阵不是可逆的，但是可以近似估计线性变换前的频谱。使用 [librosa.feature.inverse.mel_to_stft](https://librosa.org/doc/main/generated/librosa.feature.inverse.mel_to_stft.html) 完成这个操作即可。
* 用仅有功率信息的短时距傅里叶变换频谱重建音频信号：这部分是最复杂的，用 **[Griffin-Lim 算法](https://zh.wikipedia.org/wiki/Griffin-Lim%E6%BC%94%E7%AE%97%E6%B3%95)** 重建音频信号可以取得能听清的效果。使用 [librosa.griffinlim](https://librosa.org/doc/main/generated/librosa.griffinlim.html) 完成这个操作即可。（如果用 [WaveNet](https://en.wikipedia.org/wiki/WaveNet) 之类的神经网络声码器重建音频信号则可以取得非常好的效果）

实际上 librosa 直接提供了 [librosa.feature.inverse.mel_to_audio](https://librosa.org/doc/main/generated/librosa.feature.inverse.mel_to_audio.html) 函数，从梅尔频谱重建音频信号。

解题代码：

```python
import librosa
import soundfile
import numpy
from PIL import Image, ImageSequence

sr = 22050
num_freqs = 32
quantize = 2
min_db = -60
max_db = 30
fft_window_size = 2048
frame_step_size = 512
window_function_type = 'hann'

img = Image.open('flag.gif')
frames = numpy.array([numpy.array(frame.copy().convert('RGB').getdata(),dtype=numpy.uint8).reshape(frame.size[1],frame.size[0],3) for frame in ImageSequence.Iterator(img)])
log_mel_spectrogram = numpy.array([[(frame[::quantize, (x) * (quantize * 2) + quantize, 2] == 0).sum() * quantize + min_db for x in range(num_freqs)] for frame in frames]).transpose()
print(log_mel_spectrogram.shape)
mel_spectrogram = librosa.db_to_power(log_mel_spectrogram)
reconstruct = librosa.feature.inverse.mel_to_audio(mel_spectrogram, sr, n_fft=fft_window_size, hop_length=frame_step_size, window=window_function_type)
print(reconstruct.shape)
soundfile.write('flag.wav', reconstruct, sr)
```

重建效果：

[flag.wav](https://github.com/USTC-Hackergame/hackergame2021-writeups/blob/master/official/p%F0%9F%98%ADq/flag.wav)
