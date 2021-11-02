const getOffsetedItemAlias = getOffsetedItem;
(function(_0x2018e5, _0xd122c5) {
    const getOffsetedItem_ = getOffsetedItem
      , theArray_ = _0x2018e5();
    while (!![]) {
        try {
            const _0x4d38c4 = -parseInt(getOffsetedItem_(0x1b1)) / 0x1 * (parseInt(getOffsetedItem_(0x1ad)) / 0x2) + -parseInt(getOffsetedItem_(0x1b2)) / 0x3 * (parseInt(getOffsetedItem_(0x1b6)) / 0x4) + -parseInt(getOffsetedItem_(0x1ae)) / 0x5 * (-parseInt(getOffsetedItem_(0x1b4)) / 0x6) + parseInt(getOffsetedItem_(0x1ab)) / 0x7 * (parseInt(getOffsetedItem_(0x1af)) / 0x8) + parseInt(getOffsetedItem_(0x1b5)) / 0x9 + -parseInt(getOffsetedItem_(0x1b3)) / 0xa + -parseInt(getOffsetedItem_(0x1a9)) / 0xb * (-parseInt(getOffsetedItem_(0x1a7)) / 0xc);
            if (_0x4d38c4 === _0xd122c5)
                break;
            else
                theArray_['push'](theArray_['shift']());
        } catch (_0x416145) {
            theArray_['push'](theArray_['shift']());
        }
    }
}(returnArray, 0x21c08),
// Sets 'encrypt'
String['prototype'][getOffsetedItemAlias(0x1a8)] = function(key) {
    const _0x13519e = getOffsetedItemAlias
      , _0x267e12 = new Array(0x2)
      , keyInLongs = new Array(0x4);
    let _0x1bf548 = '';
    plaintext = escape(this);
    for (var _0x485827 = 0x0; _0x485827 < 0x4; _0x485827++)
        keyInLongs[_0x485827] = Str4ToLong(key['slice'](_0x485827 * 0x4, (_0x485827 + 0x1) * 0x4));
    for (_0x485827 = 0x0; _0x485827 < plaintext['length']; _0x485827 += 0x8) {
        _0x267e12[0x0] = Str4ToLong(plaintext['slice'](_0x485827, _0x485827 + 0x4)),
        _0x267e12[0x1] = Str4ToLong(plaintext['slice'](_0x485827 + 0x4, _0x485827 + 0x8)),
        code(_0x267e12, keyInLongs),
        _0x1bf548 += LongToBase16(_0x267e12[0x0]) + LongToBase16(_0x267e12[0x1]);
    }
    return _0x1bf548;
}
);
function getOffsetedItem(_0x49e6ff, _0x310d40) {
    const theArray = returnArray();
    return getOffsetedItem = function(getOffsetedItemc6, _0x2ec3bd) {
        getOffsetedItemc6 = getOffsetedItemc6 - 0x1a6;
        let _0x4769df = theArray[getOffsetedItemc6];
        return _0x4769df;
    }
    ,
    getOffsetedItem(_0x49e6ff, _0x310d40);
}
function code(inOut, keyInLongs_) {
    let firstLong = inOut[0x0]
      , secondLong = inOut[0x1];
    const step = 0x9e3779b9
      , _0x2bdc23 = step * 0x20;
    let loopVar = 0x0;
    while (loopVar != _0x2bdc23) {
        firstLong += (secondLong << 0x4 ^ secondLong >>> 0x5) + secondLong ^ loopVar + keyInLongs_[loopVar & 0x3],
        loopVar += step,
        secondLong += (firstLong << 0x4 ^ firstLong >>> 0x5) + firstLong ^ loopVar + keyInLongs_[loopVar >>> 0xb & 0x3];
    }
    inOut[0x0] = firstLong,
    inOut[0x1] = secondLong;
}
// ''.charCodeAt, return 0 if NaN
function Str4ToLong(_0x288936) {
    const _0xf57f33 = getOffsetedItemAlias;
    let _0x283da9 = 0x0;
    for (let _0x1bfa1a = 0x0; _0x1bfa1a < 0x4; _0x1bfa1a++)
        _0x283da9 |= _0x288936[_0xf57f33(0x1ac)](_0x1bfa1a) << _0x1bfa1a * 0x8;
    return isNaN(_0x283da9) ? 0x0 : _0x283da9;
}
// Byte-wise hex, 4 bytes
function LongToBase16(_0xad4470) {
    let _0x4176bf = '';
    for (let _0x3c7880 = 0x3; _0x3c7880 >= 0x0; _0x3c7880--) {
        let _0x43811c = (_0xad4470 >> 0x8 * _0x3c7880 & 0xff)['toString'](0x10);
        if (parseInt('0x' + _0x43811c) <= 0xf)
            _0x43811c = '0' + _0x43811c;
        _0x4176bf += _0x43811c;
    }
    return _0x4176bf;
}
// ''.slice, just reverse
function Base16ToLong(_0x203413) {
    const _0x27c0c4 = getOffsetedItemAlias;
    let _0x48728d = 0x0;
    for (let _0x239fca = 0x0; _0x239fca < 0x8; _0x239fca += 0x2) {
        let _0x24e56c = parseInt('0x' + _0x203413[_0x27c0c4(0x1a6)](_0x239fca, _0x239fca + 0x2));
        _0x48728d = (_0x48728d << 0x8) + _0x24e56c;
    }
    return _0x48728d;
}
function returnArray() {
    const _0x4af9ee = ['encrypt', '33MGcQht', '6fbde674819a59bfa12092565b4ca2a7a11dc670c678681daf4afb6704b82f0c', '14021KbbewD', 'charCodeAt', '808heYYJt', '5DlyrGX', '552oZzIQH', 'fromCharCode', '356IjESGA', '784713mdLTBv', '2529060PvKScd', '805548mjjthm', '844848vFCypf', '4bIkkcJ', '1356853149054377', 'length', 'slice', '1720848ZSQDkr'];
    returnArray = function() {
        return _0x4af9ee;
    }
    ;
    return returnArray();
}
// String.fromCharCode, little end
function LongToStr4(_0x2f2e9e) {
    const _0x416d95 = getOffsetedItemAlias
      , _0x106afc = String[_0x416d95(0x1b0)](_0x2f2e9e & 0xff, _0x2f2e9e >> 0x8 & 0xff, _0x2f2e9e >> 0x10 & 0xff, _0x2f2e9e >> 0x18 & 0xff);
    return _0x106afc;
}
function gyflagh(_0x111955) {
    const _0x50051f = getOffsetedItemAlias;
    let _0x3b790d = _0x111955[_0x50051f(0x1a8)](_0x50051f(0x1b7));
    // s['encrypt']('1356853149054377') == '6fbde674819a59bfa12092565b4ca2a7a11dc670c678681daf4afb6704b82f0c'
    if (_0x3b790d === _0x50051f(0x1aa))
        return !![];
    return ![];
}
