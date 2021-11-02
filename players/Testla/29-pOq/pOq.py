import typing
import librosa
import numpy
import os
import PIL.Image
import soundfile
import time


# Frames_dir = 'frames'

num_freqs = 32
quantize = 2
min_db = -60
max_db = 30
fft_window_size = 2048
frame_step_size = 512
window_function_type = 'hann'


def main() -> None:
    with PIL.Image.open('flag.gif') as im:
        num_frames = getattr(im, "n_frames", 1)
        width, height = im.size

        # os.makedirs(Frames_dir, exist_ok=True)
        gif_data: typing.List[typing.List[int]] = [[] for _ in range(32)]
        for frame_index in range(num_frames):
            im.seek(frame_index)
            # im.save(os.path.join(Frames_dir, f'{frame_index:03d}.png'))
            for freq in range(num_freqs * 2 + 1):
                if freq % 2 == 0:
                    continue
                x = freq * quantize
                y = height - 1
                db = min_db
                while db < max_db + 1 and im.getpixel((x, y)):
                    db += quantize
                    y -= quantize
                gif_data[freq // 2].append(db)
            # gif_data.append(dbs)
        gif_data = numpy.array(gif_data)
        # print(gif_data.shape)

    # https://librosa.org/doc/latest/generated/librosa.db_to_power.html    
    # https://librosa.org/doc/latest/generated/librosa.feature.inverse.mel_to_audio.html
    y = librosa.feature.inverse.mel_to_audio(
        librosa.db_to_power(gif_data),
        # n_mels?
        n_fft=fft_window_size,
        hop_length=frame_step_size,
        window=window_function_type,
    )
    # https://librosa.org/doc/latest/ioformats.html#write-out-audio-files
    soundfile.write('output.wav', y, 22050)


if __name__ == '__main__':
    main()
