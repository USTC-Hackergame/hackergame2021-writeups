def divide_64_bit(dividend: int, divisor: int) -> int:
    # Divisor must be odd number
    assert(divisor & 1)
    quotient = 0
    for position in range(64):
        power = 1 << position
        quotient_bit = power & dividend
        dividend -= divisor * quotient_bit % 2 ** 64
        dividend = (dividend + 2 ** 64) % 2 ** 64
        quotient |= quotient_bit
    return quotient


def long_to_string_le(x: int) -> str:
    result = []
    for _ in range(8):
        result.append(chr(x % 2 ** 8))
        x >>= 8
    return ''.join(result)


def main() -> None:
    # In branch <Redacted>, y must become 0.
    # x * -<Redacted> == <Redacted>
    # x |  <Redacted> == <Redacted>
    # y *  <Redacted> == <Redacted>
    # y |  <Redacted> == <Redacted>
    xa = -<Redacted> + 2 ** 64
    xb = <Redacted>
    x = divide_64_bit(xb, xa)
    assert(x * xa % 2 ** 64 == xb)
    assert((x |  <Redacted>) == <Redacted>)
    ya = <Redacted> + 2 ** 64
    yb = <Redacted>
    y = divide_64_bit(yb, ya)
    assert(y * ya % 2 ** 64 == yb)
    assert((y |  <Redacted>) == <Redacted>)

    for _ in range(13):
        # y = old_x
        # x = (old_x ^ <Redacted> | <Redacted>) * old_y
        x, y = y, divide_64_bit(x, (y ^ <Redacted> | <Redacted>))
    
    print(long_to_string_le(y) + long_to_string_le(x))

if __name__ == '__main__':
    main()

# flag{ESREVER_<Redacted>}
