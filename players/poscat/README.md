## 去吧！追寻自由的电波

这题用使用默认配置的 mpv 调整速度会产生回声，进而导致听不清... google 搜索 "mpv slow playback echo" 得知解决方法为加上 `--no-audio-pitch-correction` 参数（或写入 `mpv.conf`）

## p😭q

这题其实比较简单，只要读懂代码并找到合适的库即可，甚至不需要理解傅立叶变换是什么（当然，理解傅立叶变换/STFT肯定对理解代码有帮助）。

### 代码解读

```python
num_freqs = 32
quantize = 2
min_db = -60
max_db = 30
fft_window_size = 2048
frame_step_size = 512
window_function_type = 'hann'
red_pixel = [255, 0, 0]
white_pixel = [255, 255, 255]
y, sample_rate = librosa.load("flag.mp3")  # sample rate is 22050 Hz
```

这里定义了很多参数，并把音频载入了 `y` 和 `sample_rate`。查阅 librosa 文档可知 `y` 代表 audio time series，`sample_rate` 代表 sampling rate。

```python
spectrogram = (
    numpy.around(
        librosa.power_to_db(
            librosa.feature.melspectrogram(
                y,
                sample_rate,
                n_mels=num_freqs,
                n_fft=fft_window_size,
                hop_length=frame_step_size,
                window=window_function_type
            )
        ) / quantize
    ) * quantize
)
```

这里对载入的音频文件先后应用了 `melspectrogram`，`power_to_db` 以及 `around` 三个函数。查阅 librosa 文档可知 `melspectrogram` 将音频进行短时距傅里叶变换 (STFT) 后又把时频谱 (spectrogram) 的横轴 (频率) 的单位变为了 mel，并且 `n_mels` (即 `num_freqs`) 这个参数代表了有多少个不同的频率区间。而 `power_to_db` 则将时频谱纵轴 (振幅/声强) 的单位从功率变为了分贝。查阅 numpy 文档可知 `around` 将矩阵每个元素都进行了向下取整，考虑到先除 `quantize = 2` 后乘 `2` 可知这里将分贝向下 round 到了偶数。

最后输出的就是一个时频谱，其纵坐标单位为 db, 并且被向下 round 到了偶数，横坐标为 mel。

```python
gif_data = [
    numpy.kron(
        numpy.array([
            [red_pixel if freq % 2 and round(frame[freq // 2]) > threshold else white_pixel for threshold in list(range(
                    min_db, max_db + 1, quantize))[::-1]] for freq in range(num_freqs * 2 + 1)
        ]),
        numpy.ones([quantize, quantize, 1])
    )
    for frame in spectrogram.transpose()
]
```

查阅 librosa 文档可知 librosa 中时频谱的第一个下标代表频率，第二个下标代表帧数，矩阵元素代表强度，这里先对 spectrogram 进行了一个转置，这样遍历时就可以方便的遍历每一帧了。观察对每一个 frame 的操作，可以发现它把每一个 frame 变成了一个二阶张量（矩阵），其中每一个元素类型都是 RGB 值，而且只有红 (255,0,0) 和白 (255,255,255) 两种情况。也就是说这段代码把时频谱的每一帧转换（映射）为了 gif 图像的一帧。

再看具体转换方法: 第一个 for 遍历了 0 到 num_freqs * 2，第二个 for 遍历了 min_db 到 max_db, 并且步长为 2，最后判断时频谱该帧在频率 `freq//2` 上的强度大小是否大于 `threshold`，如果大于则涂红色，否则涂白色。这到底在干嘛？其实很容易看出或者猜出这在画柱状图。那为什么要遍历 0 到 num_freqs * 2，判断 `freq % 2` 是否是 `1` 又有什么用？这其实是在用纯白的一列像素分隔开各个柱子。之后这个 gif 帧又和一个 2x2x1 的全 `1` 三阶张量进行了一个 `kron` 运算。查阅 numpy 文档可知 `kron` 为克罗内克积。查阅维基百科可知这里克罗内克积将图片的每一个像素放大到了 2x2。打开图片正式了这一猜测：柱和柱间间隔的宽度都是两个像素。注意到遍历强度时我们的步长为 2，这里经过缩放后强度（与 min_db 的差值）正好等于纵向像素高度。

自此代码解读完毕。

### 实现解码

TLDR:
```python
import numpy
from librosa import db_to_power
from librosa.feature.inverse import mel_to_audio
import PIL.Image
import soundfile as sf

# run `ffmpeg -i flag.gif -vsync 0 flag%d.png` before running this program

num_freqs = 32
quantize = 2
min_db = -60
max_db = 30
fft_window_size = 2048
frame_step_size = 512
window_function_type = 'hann'
red_pixel = (255, 0, 0, 255)
white_pixel = (255, 255, 255, 255)
sample_rate = 22050

frames = 587


def get_max_db(pix, x):
    max = min_db - 1
    for y in range(92):
        pix_v = pix[x, 91-y]
        if pix_v == red_pixel:
            max = min_db + y
        else:
            break
    return max


def build_db_frame(i):
    img = PIL.Image.open("flag{}.png".format(i))
    pix = img.load()
    return [get_max_db(pix, 4*freq + 2) for freq in range(num_freqs)]


def main():
    db_frames = numpy.array([build_db_frame(i+1) for i in range(frames)])
    db_spectrogram = db_frames.transpose()
    power_spectrogram = db_to_power(db_spectrogram)
    audio = mel_to_audio(power_spectrogram, sample_rate,
                         n_fft=fft_window_size, hop_length=frame_step_size,
                         window=window_function_type)
    sf.write("flag.wav", audio, sample_rate, subtype='PCM_24')


if __name__ == '__main__':
    main()
```

#### 1. 图像处理

我们先把 gif 图片分离为每一帧，可以使用 ffmpeg:

```
$ ffmpeg -i flag.gif -vsync 0 flag%d.png
```

执行后可以看到生成了 `flag1.png` 到 `flag587.png` 共 587 帧图像。

接下来我们要把每一帧再转换为坐标为 mel-db 的频谱，我这里使用了 pillow 库，pillow 可以直接把每一个像素读入，但需要注意 pillow 库的坐标原点在左上方。遍历所有 4n+3 列，并记录红色像素的个数，即可得到频谱。

```python
def get_max_db(pix, x):
    max = min_db - 1
    for y in range(92):
        pix_v = pix[x, 91-y]
        if pix_v == red_pixel:
            max = min_db + y
        else:
            break
    return max


def build_db_frame(i):
    img = PIL.Image.open("flag{}.png".format(i))
    pix = img.load()
    return [get_max_db(pix, 4*freq + 3) for freq in range(num_freqs)]

def main():
    db_frames = numpy.array([build_db_frame(i+1) for i in range(frames)])
```

转置后得到时频谱

```python
db_spectrogram = db_frames.transpose()
```

#### 2. 解码时频谱

接下来我们需要解码时频谱。在 google 上搜索可知 librosa 提供了 `mel_to_audio` 这个函数将以 mel 为横坐标单位的时频谱转换为音频，而这个函数又要求强度坐标为功率，而不是分贝，再次搜索 google 可知 librosa 也提供了一个强度和分贝之间转换的函数 `db_to_power`，这样我们就可以解码了:

```python
power_spectrogram = db_to_power(db_spectrogram)
audio = mel_to_audio(power_spectrogram, sample_rate,
                     n_fft=fft_window_size,
                     hop_length=frame_step_size,
                     window=window_function_type)
```

#### 3. 输出音频文件

最后我们需要输出音频文件，在 google 上搜索可以找到 librosa 文档中 "Advanced I/O Use Cases" 一节，其中提到了使用 PySoundFile 可以非常方便的将音频输出为各种格式：

```python
sf.write("flag.wav", audio, sample_rate, subtype='PCM_24')
```

最后打开 flag.wav 即可得到 flag。

## Easy RSA

这题在理解 RSA 原理，以及一些初等数论后并不难（主要是欧拉函数的性质）。你只需找出 p, q, 求出 φ(n) = (p - 1)(q - 1) (注：φ 为欧拉函数) 后求出 e⁻¹ mod φ(n)，即私钥，即可解密密文。

### 求 p
y 很大，因而计算 y! (mod x) 及其慢，但是注意到 x, y 很接近，而且 x 为素数（我是通过 wolframalpha 知道的）联想到可以使用 wilson's theorem 简化 y! (mod x)

### 求 q
难度在于求解 e 次同余方程 q^e ≡ value_q (mod n) (注意区别这里的 n 和上面提到的 n，这里的 n 指出现在 `get_q` 中的那个)，显然，由于 q 的大小 (2²⁵⁶ 量级)，暴力是不现实的。这里注意到 e 为素数（事实上这是已知最大的费马素数），推出 gcd(e, φ(n)) = 1，推出 e⁻¹ mod φ (n) 一定存在。联想到 RSA 解密过程有关的一个引理: ed ≡ 1 (mod φ(n)) ⇒ ∀x∈ℤ, x^(ed) ≡ x (mod n)，我们可以通过计算 value_q 的 e⁻¹ 次幂解密得到 q。

### 代码

```python
import sympy
from Crypto.Util.number import *

c = 110644875422336073350488613774418819991169603750711465190260581119043921549811353108399064284589038384540018965816137286856268590507418636799746759551009749004176545414118128330198437101472882906564195341277423007542422286760940374859966152871273887950174522820162832774361714668826122465471705166574184367478

value_q = 5591130088089053683141520294620171646179623062803708281023766040254675625012293743465254007970358536660934858789388093688621793201658889399155357407224541324547522479617669812322262372851929223461622559971534394847970366311206823328200747893961649255426063204482192349202005330622561575868946656570678176047822163692259375233925446556338917358118222905050574458037965803154233167594946713038301249145097770337253930655681648299249481985768272321820718607757023350742647019762122572886601905212830744868048802864679734428398229280780215896045509020793530842541217790352661324630048261329493088812057300480085895399922301827190211956061083460036781018660201163819104150988531352228650991733072010425499238731811243310625701946882701082178190402011133439065106720309788819

e = 65537

def get_p():
  # https://cs.stackexchange.com/questions/1495/what-is-the-most-efficient-way-to-compute-factorials-modulo-a-prime
  x = 11124440021748127159092076861405454814981575144744508857178576572929321435002942998531420985771090167262256877805902135304112271641074498386662361391760451
  y = 11124440021748127159092076861405454814981575144744508857178576572929321435002942998531420985771090167262256877805902135304112271641074498386662361391661439
  n = x - y
  l = [pow(a, -1, x) for a in range(y+1,x-1)]
  prod = 1
  for i in l:
      prod = (prod * i) % x
  p = sympy.nextprime(prod)
  return p

def get_q():
  value = [80096058210213458444437404275177554701604739094679033012396452382975889905967]
  for i in range (1, 10):
    value.insert(0,sympy.prevprime(value[0]))
  n = 1
  # φ(n)
  t = 1
  for i in value:
    n = n * i
    t = t * (i - 1)
  # e^-1 (mod φ(n))
  e_inv = pow(e, -1, t)
  q0 = pow(value_q, e_inv, n)
  q = sympy.nextprime(q0)
  return q

def main():
  p = get_p()
  q = get_q()
  n = p * q
  # φ(n)
  t = (p - 1) * (q - 1)
  # e^-1 (mod φ(n))
  d = pow(e, -1, t)
  m = pow(c, d, n)
  print(m.to_bytes((m.bit_length() + 7) // 8, byteorder='big').decode("ascii"))

if __name__ == '__main__':
  main()
```

执行代码即可打印出 flag
