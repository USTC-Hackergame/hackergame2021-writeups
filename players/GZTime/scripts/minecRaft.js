function _0x381b() {
  const _0x4af9ee = [
    "encrypt",
    "33MGcQht",
    "6fbde674819a59bfa12092565b4ca2a7a11dc670c678681daf4afb6704b82f0c",
    "14021KbbewD",
    "charCodeAt",
    "808heYYJt",
    "5DlyrGX",
    "552oZzIQH",
    "fromCharCode",
    "356IjESGA",
    "784713mdLTBv",
    "2529060PvKScd",
    "805548mjjthm",
    "844848vFCypf",
    "4bIkkcJ",
    "1356853149054377",
    "length",
    "slice",
    "1720848ZSQDkr",
  ];
  _0x381b = function () {
    return _0x4af9ee;
  };
  return _0x381b();
}

function _0x2c9e(_0x49e6ff, _0x310d40) {
  const _0x381b4c = _0x381b();
  return (
    (_0x2c9e = function (_0x2c9ec6, _0x2ec3bd) {
      _0x2c9ec6 = _0x2c9ec6 - 0x1a6;
      let _0x4769df = _0x381b4c[_0x2c9ec6];
      return _0x4769df;
    }),
    _0x2c9e(_0x49e6ff, _0x310d40)
  );
}
const _0x22517d = _0x2c9e;

(function (_0x2018e5, _0xd122c5) {
  const _0x4a600d = _0x2c9e,
    _0x2e34d2 = _0x2018e5();
  while (!![]) {
    try {
      const _0x4d38c4 =
        (-parseInt(_0x4a600d(0x1b1)) / 0x1) *
          (parseInt(_0x4a600d(0x1ad)) / 0x2) +
        (-parseInt(_0x4a600d(0x1b2)) / 0x3) *
          (parseInt(_0x4a600d(0x1b6)) / 0x4) +
        (-parseInt(_0x4a600d(0x1ae)) / 0x5) *
          (-parseInt(_0x4a600d(0x1b4)) / 0x6) +
        (parseInt(_0x4a600d(0x1ab)) / 0x7) *
          (parseInt(_0x4a600d(0x1af)) / 0x8) +
        parseInt(_0x4a600d(0x1b5)) / 0x9 +
        -parseInt(_0x4a600d(0x1b3)) / 0xa +
        (-parseInt(_0x4a600d(0x1a9)) / 0xb) *
          (-parseInt(_0x4a600d(0x1a7)) / 0xc);
      if (_0x4d38c4 === _0xd122c5) break;
      else _0x2e34d2["push"](_0x2e34d2["shift"]());
    } catch (_0x416145) {
      _0x2e34d2["push"](_0x2e34d2["shift"]());
    }
  }
})(_0x381b, 0x21c08);

function LongToStr4(_0x2f2e9e) {
  const _0x416d95 = _0x22517d,
    _0x106afc = String[_0x416d95(0x1b0)](
      _0x2f2e9e & 0xff,
      (_0x2f2e9e >> 0x8) & 0xff,
      (_0x2f2e9e >> 0x10) & 0xff,
      (_0x2f2e9e >> 0x18) & 0xff
    );
  return _0x106afc;
}
function Str4ToLong(_0x288936) {
  const _0xf57f33 = _0x22517d;
  let _0x283da9 = 0x0;
  for (let _0x1bfa1a = 0x0; _0x1bfa1a < 0x4; _0x1bfa1a++)
    _0x283da9 |= _0x288936[_0xf57f33(0x1ac)](_0x1bfa1a) << (_0x1bfa1a * 0x8);
  return isNaN(_0x283da9) ? 0x0 : _0x283da9;
}
function LongToBase16(_0xad4470) {
    let _0x4176bf = "";
    for (let _0x3c7880 = 0x3; _0x3c7880 >= 0x0; _0x3c7880--) {
      let _0x43811c = ((_0xad4470 >> (0x8 * _0x3c7880)) & 0xff)["toString"](0x10);
      if (parseInt("0x" + _0x43811c) <= 0xf) _0x43811c = "0" + _0x43811c;
      _0x4176bf += _0x43811c;
    }
    return _0x4176bf;
  }
function Base16ToLong(_0x203413) {
  const _0x27c0c4 = _0x22517d;
  let _0x48728d = 0x0;
  for (let _0x239fca = 0x0; _0x239fca < 0x8; _0x239fca += 0x2) {
    let _0x24e56c = parseInt(
      "0x" + _0x203413[_0x27c0c4(0x1a6)](_0x239fca, _0x239fca + 0x2)
    );
    _0x48728d = (_0x48728d << 0x8) + _0x24e56c;
  }
  return _0x48728d;
}

function decode(v, k) {
  let highbit = v[0],
    lowbit = v[1];
  const delta = 0x9e3779b9;
  let now = delta * 0x20;
  while (now != 0) {
    lowbit -=
      (((highbit << 4) ^ (highbit >>> 5)) + highbit) ^
      (now + k[(now >>> 11) & 3]);
    now -= delta;
    highbit -= (((lowbit << 4) ^ (lowbit >>> 5)) + lowbit) ^ (now + k[now & 3]);
  }
  v[0] = highbit;
  v[1] = lowbit;
}

function code(v, k) {
  let highbit = v[0],
    lowbit = v[1];
  const delta = 0x9e3779b9,
    tot = delta * 0x20;
  let sum = 0x0;
  while (sum != tot) {
    highbit += (((lowbit << 4) ^ (lowbit >>> 5)) + lowbit) ^ (sum + k[sum & 3]);
    sum += delta;
    lowbit +=
      (((highbit << 4) ^ (highbit >>> 5)) + highbit) ^
      (sum + k[(sum >>> 11) & 3]);
  }
  v[0] = highbit;
  v[1] = lowbit;
}

String["prototype"]["encrypt"] = function (keystr) {
  const result = new Array(2),
    key = new Array(4);
  let ans = "";
  plaintext = escape(this);
  for (var i = 0; i < 4; i++)
    key[i] = Str4ToLong(keystr.slice(i * 4, (i + 1) * 4));
  for (i = 0; i < plaintext.length; i += 8) {
    result[0] = Str4ToLong(plaintext.slice(i, i + 4));
    result[1] = Str4ToLong(plaintext.slice(i + 4, i + 8));
    code(result, key);
    ans += LongToBase16(result[0]) + LongToBase16(result[1]);
  }
  return ans;
};

String["prototype"]["decrypt"] = function (keystr) {
  const result = new Array(2),
    key = new Array(4);
  let ans = "";
  ciphertext = escape(this);
  for (var i = 0; i < 4; i++)
    key[i] = Str4ToLong(keystr.slice(i * 4, (i + 1) * 4));
  for (i = 0; i < ciphertext.length; i += 16) {
    result[0] = Base16ToLong(ciphertext.slice(i, i + 8));
    result[1] = Base16ToLong(ciphertext.slice(i + 8, i + 16));
    decode(result, key);
    ans += LongToStr4(result[0]) + LongToStr4(result[1]);
  }
  return ans;
};

let ciphertext =
  "6fbde674819a59bfa12092565b4ca2a7a11dc670c678681daf4afb6704b82f0c";
let key = "1356853149054377";
let flag = ciphertext.decrypt(key);

console.log('flag{' + flag + '}');
console.log(flag.encrypt(key) == ciphertext);
