// reverse function
function decode(inOut, keyInLongs_) {
    let firstLong = inOut[0x0]
      , secondLong = inOut[0x1];
    const step = 0x9e3779b9;
    let loopVar = step * 0x20;
    while (loopVar != 0) {
        secondLong -= (firstLong << 0x4 ^ firstLong >>> 0x5) + firstLong ^ loopVar + keyInLongs_[loopVar >>> 0xb & 0x3];
        loopVar -= step;
        firstLong -= (secondLong << 0x4 ^ secondLong >>> 0x5) + secondLong ^ loopVar + keyInLongs_[loopVar & 0x3];
    }
    inOut[0x0] = firstLong,
    inOut[0x1] = secondLong;
}

String['prototype']['decrpyt'] = function(key) {
    const
        temp = new Array(0x2)
      , keyInLongs = new Array(0x4);
    let result = '';
    ciphertext = escape(this);
    for (var loopVar = 0x0; loopVar < 0x4; loopVar++)
        keyInLongs[loopVar] = Str4ToLong(key['slice'](loopVar * 0x4, (loopVar + 0x1) * 0x4));
    for (loopVar = 0x0; loopVar < plaintext['length']; loopVar += 0x10) {
        temp[0] = Base16ToLong(ciphertext.slice(loopVar, loopVar + 8));
        temp[1] = Base16ToLong(ciphertext.slice(loopVar + 8, loopVar + 16));
        decode(temp, keyInLongs);
        result += LongToStr4(temp[0]) + LongToStr4(temp[1]);
    }
    return result;
}

'6fbde674819a59bfa12092565b4ca2a7a11dc670c678681daf4afb6704b82f0c'.decrpyt('1356853149054377')
