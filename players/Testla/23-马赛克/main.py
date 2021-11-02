import itertools
import math
from os import sep
import numpy as np
import PIL.Image

X, Y = 103, 137     # 马赛克左上角位置(单位为像素)
N = 20              # 马赛克块的数量（共N*N块）
BOX_SIZE = 23       # 每个马赛克块的大小（边长，单位为像素）
PIXEL_SIZE = 11     # 二维码每个块的大小（边长，单位为像素）

Unknown_pixel = 128


def pixels_to_image(pixels: np.array) -> np.array:
    return np.array(
        [[pixels[i // PIXEL_SIZE][j // PIXEL_SIZE]
        for j in range(pixels.shape[1] * PIXEL_SIZE)]
        for i in range(pixels.shape[0] * PIXEL_SIZE)],
        dtype=np.uint8)

def export(image: np.array, filename: str) -> None:
    with PIL.Image.fromarray(image) as im:
        im.save(filename)


def main() -> None:
    with PIL.Image.open('pixelated_qrcode.bmp') as im:
        # print(im.size, im.format, im.mode, im.info)

        # print(im.getpixel((Y, X)))
        # print(im.getpixel((Y - 1, X)))
        # print(im.getpixel((Y, X - 1)))

        a = np.asarray(im, dtype=np.uint8)
        # print(a[X][Y])
        # print(a[X - 1][Y])
        # print(a[X][Y - 1])

        pixels = np.empty((im.width // PIXEL_SIZE, im.height // PIXEL_SIZE))
        for i, j in np.ndindex(im.height // PIXEL_SIZE, im.width // PIXEL_SIZE):
            pixel = a[
                i * PIXEL_SIZE: (i + 1) * PIXEL_SIZE,
                j * PIXEL_SIZE: (j + 1) * PIXEL_SIZE,]
            # if 0 in pixel:
            # if pixel.mean() == 0:
            s = pixel.sum()
            if s == 0:
                pixels[i][j] = 0
            # elif 255 in pixel:
            # elif pixel.mean() == 255:
            elif s == 255 * pixel.size:
                pixels[i][j] = 255
            else:
                pixels[i][j] = Unknown_pixel

        boxes = np.empty((N, N))
        for i, j in np.ndindex(N, N):
            boxes[i][j] = a[X + i * BOX_SIZE][[Y + j * BOX_SIZE]]
        # np.set_printoptions(linewidth=120)
        # print(boxes)

    export(pixels_to_image(pixels), '2.bmp')
    new_image = pixels_to_image(pixels)

    # Enumberate all possibilties of unknown pixels, if a pixel is the same color in all valid cases, use it.
    for num_pass in range(1, 10 + 1):
        for i, j in np.ndindex(N, N):
            unknown_pixels = [
                (x, y)
                    for x in range(
                        (X + i * BOX_SIZE) // PIXEL_SIZE,
                        (X + (i + 1) * BOX_SIZE - 1) // PIXEL_SIZE + 1)
                    for y in range(
                        (Y + j * BOX_SIZE) // PIXEL_SIZE,
                        (Y + (j + 1) * BOX_SIZE - 1) // PIXEL_SIZE + 1)
                if pixels[x][y] == 128
            ]

            if len(unknown_pixels) == 0:
                continue

            result = []
            for case in itertools.product(*(((0, 255),) * len(unknown_pixels))):
                for unknown_pixel, color in zip(unknown_pixels, case):
                    new_image[
                        unknown_pixel[0] * PIXEL_SIZE: (unknown_pixel[0] + 1) * PIXEL_SIZE,
                        unknown_pixel[1] * PIXEL_SIZE: (unknown_pixel[1] + 1) * PIXEL_SIZE
                    ] = color
                result.append((
                    case,
                    new_image[
                        X + i * BOX_SIZE: X + (i + 1) * BOX_SIZE,
                        Y + j * BOX_SIZE: Y + (j + 1) * BOX_SIZE,
                    ].mean()))
            valid_results = list(filter(lambda t: math.floor(t[1]) == boxes[i][j], result))

            # This is wrong
            # exact_result = list(filter(lambda t: t[1] == boxes[i][j], valid_result))
            # if len(exact_result) == 1:
            #     print('exact', i, j, exact_result)
            #     valid_result = exact_result

            # print(valid_results[0][0])
            # print(*valid_results, sep='\n')
            invariants = [
                (valid_results[0][0][unknown_pixel_index]
                    if all(
                        (valid_result[0][unknown_pixel_index]
                            == valid_results[0][0][unknown_pixel_index])
                        for valid_result in valid_results)
                    else None)
                for unknown_pixel_index in range(len(unknown_pixels))
            ]

            for i, unknown_pixel in enumerate(unknown_pixels):
                pixels[unknown_pixel[0]][unknown_pixel[1]] = \
                    invariants[i] if invariants[i] is not None else Unknown_pixel
                new_image[
                    unknown_pixel[0] * PIXEL_SIZE: (unknown_pixel[0] + 1) * PIXEL_SIZE,
                    unknown_pixel[1] * PIXEL_SIZE: (unknown_pixel[1] + 1) * PIXEL_SIZE
                ] = pixels[unknown_pixel[0]][unknown_pixel[1]]

        export(new_image, f'pass_{num_pass}.bmp')


if __name__ == '__main__':
    main()
