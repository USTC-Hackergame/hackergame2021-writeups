# pð­q

é¢è§£ä½èï¼[æ¾æäº®](https://github.com/mlzeng)

åºé¢äººãéªé¢äººãææ¡è®¾è®¡ç­ï¼è§ [Hackergame 2021 å¹åå·¥ä½äººå](https://hack.lug.ustc.edu.cn/credits/)ã

## é¢ç®æè¿°

- é¢ç®åç±»ï¼general

- é¢ç®åå¼ï¼400

- é¢ç®é¾æ¥ï¼[src/fourier.zip](src/fourier.zip)

å­¦ä¼åéå¶çä¸ç¬é´ï¼ææ¨çæ³ªæ°´æµäºä¸æ¥ã

å½æçå°é³é¢æ­æ¾å¨ä¸­è·³å¨çé¢è°±å¨ç»ï¼æææç¨çå¤æï¼æ·±éçé¶æ²³ï¼åªæå¤©ä½¿å¨æµåä½å±ï¼å¤æçææäºæç¼ä¸­æº¢åºï¼åæ¯æ²å¥äºé¾éæ¦è§çæµ·ä¸æ ·çæ¸©æã

è¿ä¸å»ææç¥éï¼è³æºé³åä¹å°±å¾ä¸ä¹ï¼çå¬é³ä¹è¿å¾é ç¼çã

![fourier.gif](src/fourier.gif)

ï¼æ³¨æï¼flag è±æ¬å·åæ¯ä¸ä¸ª 12 ä½æ´æ°ï¼ç± 0-9 æ°ä½ç»æï¼æ²¡æå¶å®å­ç¬¦ãï¼

**ç¹å»ä¸é¢æé®ä¸è½½æºä»£ç ä¸å¾ç**

## é¢è§£

å¦ææ¯é¡¶å° HiFi ç©å®¶ï¼å¯ä»¥ç´æ¥çé¢è°±å¾å¾å°ç­æ¡ãå¦ææ²¡æè¿æ ·çå¤©åï¼ä¹å¯ä»¥ç¨é¢è°±å¾è¿åé³é¢ä¿¡å·ï¼ç¶åå¬é³é¢å¾å°ç­æ¡ã

æ ¹æ®é¢è°±å¾çæä»£ç å¯ä»¥çåºé¢è°±å¾æ°æ®æ¯ä½¿ç¨ librosa è®¡ç®å¾å°çãæ ¹æ® librosa ææ¡£ [librosa.feature.melspectrogram](https://librosa.org/doc/main/generated/librosa.feature.melspectrogram.html) ååéå¶ç¸å³èµæçè§£é³é¢ä¿¡å·å¤çè¿ç¨ï¼

* ç­æ¶è·åéå¶åæ¢ï¼ä½¿ç¨æ±æçªï¼æ»å¨çªå£é¿åº¦ä¸º 2048 ä¸ªéæ ·ç¹ï¼æ¯å¸§çªå£ç§»å¨ 512 ä¸ªéæ ·ç¹ãå®æåæ¢åï¼å¯¹ç»æçææå¤æ°å¼åç»å¯¹å¼å¹³æ¹ï¼å³ä¸¢å¼æ¯ä¸ªé¢çä¸çç¸ä½ä¿¡æ¯ï¼ä»ä¿çåçä¿¡æ¯ï¼ã
* æ¢å°æ»¤æ³¢ï¼å°ç­æ¶è·åéå¶åæ¢å¾å°ç 1025 ä¸ªé¢çä¸çåçä¿¡æ¯ç»è¿æ¢å°è¿æ»¤ç©éµ [librosa.filters.mel](https://librosa.org/doc/main/generated/librosa.filters.mel.html) çº¿æ§åæ¢ï¼ï¼ææï¼åç¼©åå¹¶å° 32 ä¸ªé¢çä¸ï¼åææ¢å°é¢è°±ã
* å°åçå¼è½¬æ¢ä¸ºåè´å¼ï¼å¹¶å°æ°å¼éåå° 2 çæ´æ°åï¼

é£ä¹åªè¦ä»é¢è°±å¾ GIF ä¸­è§£æåºé¢è°±å¾æ°æ®ï¼æ ¹æ®å¤çè¿ç¨éåæ¢è¿åé³é¢ä¿¡å·æ°æ®å³å¯ï¼

* å°åè´å¼è½¬æ¢ä¸ºåçå¼

* æ¢å°æ»¤æ³¢éåæ¢ï¼è½ç¶æ¢å°è¿æ»¤ç©éµä¸æ¯å¯éçï¼ä½æ¯å¯ä»¥è¿ä¼¼ä¼°è®¡çº¿æ§åæ¢åçé¢è°±ãä½¿ç¨ [librosa.feature.inverse.mel_to_stft](https://librosa.org/doc/main/generated/librosa.feature.inverse.mel_to_stft.html) å®æè¿ä¸ªæä½å³å¯ã
* ç¨ä»æåçä¿¡æ¯çç­æ¶è·åéå¶åæ¢é¢è°±éå»ºé³é¢ä¿¡å·ï¼è¿é¨åæ¯æå¤æçï¼ç¨ **[Griffin-Lim ç®æ³](https://zh.wikipedia.org/wiki/Griffin-Lim%E6%BC%94%E7%AE%97%E6%B3%95)** éå»ºé³é¢ä¿¡å·å¯ä»¥åå¾è½å¬æ¸çææãä½¿ç¨ [librosa.griffinlim](https://librosa.org/doc/main/generated/librosa.griffinlim.html) å®æè¿ä¸ªæä½å³å¯ãï¼å¦æç¨ [WaveNet](https://en.wikipedia.org/wiki/WaveNet) ä¹ç±»çç¥ç»ç½ç»å£°ç å¨éå»ºé³é¢ä¿¡å·åå¯ä»¥åå¾éå¸¸å¥½çææï¼

å®éä¸ librosa ç´æ¥æä¾äº [librosa.feature.inverse.mel_to_audio](https://librosa.org/doc/main/generated/librosa.feature.inverse.mel_to_audio.html) å½æ°ï¼ä»æ¢å°é¢è°±éå»ºé³é¢ä¿¡å·ã

è§£é¢ä»£ç ï¼

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

éå»ºææï¼

[flag.wav](https://github.com/USTC-Hackergame/hackergame2021-writeups/blob/master/official/p%F0%9F%98%ADq/flag.wav)
