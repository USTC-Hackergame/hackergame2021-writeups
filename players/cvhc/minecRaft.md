## minecRaft

Firefox，F12 -> Debugger，找到 `flag.js`，右键 Pretty print source。加几个断点。会发现主要入口是 `gyflagh` 这个函数。没几行不妨人工整理一下：

```javascript
// key 是踩出来的字符序列，长度 32
function gyflagh(key) {
  let cipher = key.encrypt('1356853149054377');
  if (cipher === '6fbde674819a59bfa12092565b4ca2a7a11dc670c678681daf4afb6704b82f0c')
    return true;
  return false;
}
```

进 `encrypt` 函数单步，发现主要加密算法好像是在 `code` 函数里面。开始尝试人工整理：

```javascript
function code(arr, key) {
  let x1 = arr[0], x2 = arr[1];
  const a = 0x9e3779b9;
  const b = a * 32;

  let n = 0;
  while (n != b) {
    x1 += (x2 << 4 ^ x2 >>> 5) + x2 ^ n + key[n & 3];
    n += a;
    x2 += (x1 << 4 ^ x1 >>> 5) + x1 ^ n + key[n >>> 11 & 3];
  }

  arr[0] = x1,
  arr[1] = x2
}
```

此处冒出个 magic number，必有蹊跷。以 `0x9e3779b9 encrypt javascript` 为关键字搜索，**马上发现[看起来一模一样的代码](https://www.movable-type.co.uk/scripts/tea.html)**。原来是 TEA 算法啊（并没有听说过），把代码抄过来。注意网上代码是用 `Str4ToLong/LongToStr4` 编码字节串的，本题中一些部分用的是 `Base16ToLong/LongToBase16`，需要相应调整一下。

修改后的完整代码如下：

```javascript
function encrypt(plaintext, password) {
  var v = new Array(2), k = new Array(4), s = "", i;

  plaintext = escape(plaintext);  // use escape() so only have single-byte chars to encode

  // build key directly from 1st 16 chars of password
  for (var i=0; i<4; i++) k[i] = Str4ToLong(password.slice(i*4,(i+1)*4));

  for (i=0; i<plaintext.length; i+=8) {  // encode plaintext into s in 64-bit (8 char) blocks
    v[0] = Str4ToLong(plaintext.slice(i,i+4));  // ... note this is 'electronic codebook' mode
    v[1] = Str4ToLong(plaintext.slice(i+4,i+8));
    code(v, k);
    s += LongToBase16(v[0]) + LongToBase16(v[1]);
  }

  return escCtrlCh(s);
  // note: if plaintext or password are passed as string objects, rather than strings, this
  // function will throw an 'Object doesn't support this property or method' error
}

// use (16 chars of) 'password' to decrypt 'ciphertext' with xTEA
function decrypt(ciphertext, password) {
  var v = new Array(2), k = new Array(4), s = "", i;

  for (var i=0; i<4; i++) k[i] = Str4ToLong(password.slice(i*4,(i+1)*4));

  ciphertext = unescCtrlCh(ciphertext);
  for (i=0; i<ciphertext.length; i+=16) {  // decode ciphertext into s in 64-bit (8 char) blocks
    //v[0] = Str4ToLong(ciphertext.slice(i,i+4));
    //v[1] = Str4ToLong(ciphertext.slice(i+4,i+8));
    v[0] = Base16ToLong(ciphertext.slice(i,i+8));
    v[1] = Base16ToLong(ciphertext.slice(i+8,i+16));
    decode(v, k);
    s += LongToStr4(v[0]) + LongToStr4(v[1]);
  }

  // strip trailing null chars resulting from filling 4-char blocks:
  s = s.replace(/\0+$/, '');

  return unescape(s);
}


function code(v, k) {
  // Extended TEA: this is the 1997 revised version of Needham & Wheeler's algorithm
  // params: v[2] 64-bit value block; k[4] 128-bit key
  var y = v[0], z = v[1];
  var delta = 0x9E3779B9, limit = delta*32, sum = 0;

  while (sum != limit) {
    y += (z<<4 ^ z>>>5)+z ^ sum+k[sum & 3];
    sum += delta;
    z += (y<<4 ^ y>>>5)+y ^ sum+k[sum>>>11 & 3];
    // note: unsigned right-shift '>>>' is used in place of original '>>', due to lack
    // of 'unsigned' type declaration in JavaScript (thanks to Karsten Kraus for this)
  }
  v[0] = y; v[1] = z;
}

function decode(v, k) {
  var y = v[0], z = v[1];
  var delta = 0x9E3779B9, sum = delta*32;

  while (sum != 0) {
    z -= (y<<4 ^ y>>>5)+y ^ sum+k[sum>>>11 & 3];
    sum -= delta;
    y -= (z<<4 ^ z>>>5)+z ^ sum+k[sum & 3];
  }
  v[0] = y; v[1] = z;
}

// supporting functions
function Str4ToLong(s) {  // convert 4 chars of s to a numeric long
  var v = 0;
  for (var i=0; i<4; i++) v |= s.charCodeAt(i) << i*8;
  return isNaN(v) ? 0 : v;
}

function LongToStr4(v) {  // convert a numeric long to 4 char string
  var s = String.fromCharCode(v & 0xFF, v>>8 & 0xFF, v>>16 & 0xFF, v>>24 & 0xFF);
  return s;
}

function escCtrlCh(str) {  // escape control chars which might cause problems with encrypted texts
  return str.replace(/[\0\t\n\v\f\r\xa0'"!]/g, function(c) { return '!' + c.charCodeAt(0) + '!'; });
}

function unescCtrlCh(str) {  // unescape potentially problematic nulls and control characters
  return str.replace(/!\d\d?\d?!/g, function(c) { return String.fromCharCode(c.slice(1,-1)); });
}

function Base16ToLong(_0x203413) {
  let _0x48728d = 0;
  for (let _0x239fca = 0; _0x239fca < 8; _0x239fca += 2) {
    let _0x24e56c = parseInt('0x' + _0x203413["slice"](_0x239fca, _0x239fca + 2));
    _0x48728d = (_0x48728d << 8) + _0x24e56c;
  }
  return _0x48728d;
}

function LongToBase16(_0xad4470) {
  let _0x4176bf = '';
  for (let _0x3c7880 = 3; _0x3c7880 >= 0; _0x3c7880--) {
    let _0x43811c = (_0xad4470 >> 8 * _0x3c7880 & 255) ['toString'](16);
    if (parseInt('0x' + _0x43811c) <= 15) _0x43811c = '0' + _0x43811c;
    _0x4176bf += _0x43811c;
  }
  return _0x4176bf;
}

console.log(encrypt('onmNLKJ2RQPMLKJIHcCDE016OPQRSTUV', '1356853149054377'))
console.log(decrypt('aa50caf1d18ea107fa0496ee3ae7bf154cbb7cc7aec686f45c9c207b4d6017f3', '1356853149054377'))
console.log(decrypt('6fbde674819a59bfa12092565b4ca2a7a11dc670c678681daf4afb6704b82f0c', '1356853149054377'))
```