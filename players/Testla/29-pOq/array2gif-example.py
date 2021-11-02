import numpy as np
from array2gif import write_gif

dataset = [
    np.array([
        [[255, 0, 0], [255, 0, 0]],  # red intensities
        [[0, 255, 0], [0, 255, 0]],  # green intensities
        [[0, 0, 255], [0, 0, 255]]   # blue intensities
    ]),
    np.array([
        [[0, 0, 255], [0, 0, 255]],
        [[0, 255, 0], [0, 255, 0]],
        [[255, 0, 0], [255, 0, 0]]
    ])
]
write_gif(dataset, 'rgbbgr.gif', fps=5)

# or for just a still GIF
write_gif(dataset[0], 'rgb.gif')
