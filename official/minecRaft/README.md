# minecRaft

题解作者：[George fe](https://github.com/Georgefwt)

题解编辑：[taoky](https://github.com/taoky)

出题人、验题人、文案设计等：见 [Hackergame 2021 幕后工作人员](https://hack.lug.ustc.edu.cn/credits/)。

## 题目描述

- 题目分类：web

- 题目分值：300

- 题目链接：[http://202.38.93.111:12899/](http://202.38.93.111:12899/)

kk 同学很喜欢玩 Minecraft，他最近收到了一张 MC 地图，地图里面有三盏灯，还有很多奇奇怪怪的压力板。

但他发现这些灯好像不太符合 MC 电磁学（Red stone），你能帮他把灯全部点亮吗？

注：本题解法与原版 Minecraft 游戏无关。

**补充说明：flag 花括号内为让三盏灯全部点亮的最短的输入序列。例如，如果踩踏压力板输入的最短的序列为 abc，则答案为 flag{abc}。**

## 题解

网站作者在 release 网站的时候为了防止网站源代码被轻易解读，一般都会使用 webpack 或 JavaScript 混淆等技术，本题考查点在于对 JavaScript 文件的逆向。

打开网站游玩会发现第一盏灯只要踩到第二行的任意踏板就可以激活，第二盏灯需要第一个字母踩到 M 才可以点亮。根据提示需要点亮第三盏灯。所以需要查看代码逻辑。

查看发现 flag.js

prettify 后：

```javascript
const _0x22517d = _0x2c9e;
(function(_0x2018e5, _0xd122c5) {
        const _0x4a600d = _0x2c9e,
            _0x2e34d2 = _0x2018e5();
        while (!![]) {
            try {
                const _0x4d38c4 = -parseInt(_0x4a600d(0x1b1)) / 0x1 * (parseInt(_0x4a600d(0x1ad)) / 0x2) + -parseInt(_0x4a600d(0x1b2)) / 0x3 * (parseInt(_0x4a600d(0x1b6)) / 0x4) + -parseInt(_0x4a600d(0x1ae)) / 0x5 * (-parseInt(_0x4a600d(0x1b4)) / 0x6) + parseInt(_0x4a600d(0x1ab)) / 0x7 * (parseInt(_0x4a600d(0x1af)) / 0x8) + parseInt(_0x4a600d(0x1b5)) / 0x9 + -parseInt(_0x4a600d(0x1b3)) / 0xa + -parseInt(_0x4a600d(0x1a9)) / 0xb * (-parseInt(_0x4a600d(0x1a7)) / 0xc);
                if (_0x4d38c4 === _0xd122c5)
                    break;
                else
                    _0x2e34d2['push'](_0x2e34d2['shift']());
            } catch (_0x416145) {
                _0x2e34d2['push'](_0x2e34d2['shift']());
            }
        }
    }(_0x381b, 0x21c08),
    String['prototype'][_0x22517d(0x1a8)] = function(_0x6a2659) {
        const _0x13519e = _0x22517d,
            _0x267e12 = new Array(0x2),
            _0x11a961 = new Array(0x4);
        let _0x1bf548 = '';
        plaintext = escape(this);
        for (var _0x485827 = 0x0; _0x485827 < 0x4; _0x485827++)
            _0x11a961[_0x485827] = Str4ToLong(_0x6a2659[_0x13519e(0x1a6)](_0x485827 * 0x4, (_0x485827 + 0x1) * 0x4));
        for (_0x485827 = 0x0; _0x485827 < plaintext[_0x13519e(0x1b8)]; _0x485827 += 0x8) {
            _0x267e12[0x0] = Str4ToLong(plaintext['slice'](_0x485827, _0x485827 + 0x4)),
                _0x267e12[0x1] = Str4ToLong(plaintext[_0x13519e(0x1a6)](_0x485827 + 0x4, _0x485827 + 0x8)),
                code(_0x267e12, _0x11a961),
                _0x1bf548 += LongToBase16(_0x267e12[0x0]) + LongToBase16(_0x267e12[0x1]);
        }
        return _0x1bf548;
    }
);

function _0x2c9e(_0x49e6ff, _0x310d40) {
    const _0x381b4c = _0x381b();
    return _0x2c9e = function(_0x2c9ec6, _0x2ec3bd) {
            _0x2c9ec6 = _0x2c9ec6 - 0x1a6;
            let _0x4769df = _0x381b4c[_0x2c9ec6];
            return _0x4769df;
        },
        _0x2c9e(_0x49e6ff, _0x310d40);
}

function code(_0x167a71, _0x762113) {
    let _0x412874 = _0x167a71[0x0],
        _0x3f9c14 = _0x167a71[0x1];
    const _0x540f95 = (0x52cfb2de + 0x4b67c6db),
        _0x2bdc23 = _0x540f95 * 0x20;
    let _0x4f8e47 = 0x0;
    while (_0x4f8e47 != _0x2bdc23) {
        _0x412874 += (_0x3f9c14 << 0x4 ^ _0x3f9c14 >>> 0x5) + _0x3f9c14 ^ _0x4f8e47 + _0x762113[_0x4f8e47 & 0x3],
            _0x4f8e47 += _0x540f95,
            _0x3f9c14 += (_0x412874 << 0x4 ^ _0x412874 >>> 0x5) + _0x412874 ^ _0x4f8e47 + _0x762113[_0x4f8e47 >>> 0xb & 0x3];
    }
    _0x167a71[0x0] = _0x412874,
        _0x167a71[0x1] = _0x3f9c14;
}

function Str4ToLong(_0x288936) {
    const _0xf57f33 = _0x22517d;
    let _0x283da9 = 0x0;
    for (let _0x1bfa1a = 0x0; _0x1bfa1a < 0x4; _0x1bfa1a++)
        _0x283da9 |= _0x288936[_0xf57f33(0x1ac)](_0x1bfa1a) << _0x1bfa1a * 0x8;
    return isNaN(_0x283da9) ? 0x0 : _0x283da9;
}

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

function Base16ToLong(_0x203413) {
    const _0x27c0c4 = _0x22517d;
    let _0x48728d = 0x0;
    for (let _0x239fca = 0x0; _0x239fca < 0x8; _0x239fca += 0x2) {
        let _0x24e56c = parseInt('0x' + _0x203413[_0x27c0c4(0x1a6)](_0x239fca, _0x239fca + 0x2));
        _0x48728d = (_0x48728d << 0x8) + _0x24e56c;
    }
    return _0x48728d;
}

function _0x381b() {
    const _0x4af9ee = ['encrypt', '33MGcQht', '6fbde674819a59bfa12092565b4ca2a7a11dc670c678681daf4afb6704b82f0c', '14021KbbewD', 'charCodeAt', '808heYYJt', '5DlyrGX', '552oZzIQH', 'fromCharCode', '356IjESGA', '784713mdLTBv', '2529060PvKScd', '805548mjjthm', '844848vFCypf', '4bIkkcJ', '1356853149054377', 'length', 'slice', '1720848ZSQDkr'];
    _0x381b = function() {
        return _0x4af9ee;
    };
    return _0x381b();
}

function LongToStr4(_0x2f2e9e) {
    const _0x416d95 = _0x22517d,
        _0x106afc = String[_0x416d95(0x1b0)](_0x2f2e9e & 0xff, _0x2f2e9e >> 0x8 & 0xff, _0x2f2e9e >> 0x10 & 0xff, _0x2f2e9e >> 0x18 & 0xff);
    return _0x106afc;
}

function gyflagh(_0x111955) {
    const _0x50051f = _0x22517d;
    let _0x3b790d = _0x111955[_0x50051f(0x1a8)](_0x50051f(0x1b7));
    if (_0x3b790d === _0x50051f(0x1aa))
        return !![];
    return ![];
}
```

开始逆向整理：

```javascript
(function f() {
    strlist2 = strList();
    while (true) {
        try {
            const _0x4d38c4 = -parseInt(getString(0x1b1)) / 0x1 *
                (parseInt(getString(0x1ad)) / 0x2) +
                -parseInt(getString(0x1b2)) / 0x3 *
                (parseInt(getString(0x1b6)) / 0x4) +
                -parseInt(getString(0x1ae)) / 0x5 *
                (-parseInt(getString(0x1b4)) / 0x6) +
                parseInt(getString(0x1ab)) / 0x7 *
                (parseInt(getString(0x1af)) / 0x8) +
                parseInt(getString(0x1b5)) / 0x9 +
                -parseInt(getString(0x1b3)) / 0xa +
                -parseInt(getString(0x1a9)) / 0xb *
                (-parseInt(getString(0x1a7)) / 0xc);
            if (_0x4d38c4 === 0x21c08)
                break;
            else
                strlist2['push'](strlist2['shift']());
        } catch (_0x416145) {
            strlist2['push'](strlist2['shift']());
        }
    }
}());

String['prototype'][getString(0x1a8)] = function(password) {
    const v = new Array(2);
    const k = new Array(4);
    let s = '';
    plaintext = escape(this);
    for (var i = 0; i < 4; i++)
        k[i] = Str4ToLong(password[getString(0x1a6)](i * 4, (i + 1) * 4));
    for (i = 0; i < plaintext[getString(0x1b8)]; i += 8) {
        v[0] = Str4ToLong(plaintext['slice'](i, i + 4));
        v[1] = Str4ToLong(plaintext[getString(0x1a6)](i + 4, i + 8));
        code(v, k);
        s += LongToBase16(v[0]) + LongToBase16(v[1]);
    }
    return s;
}

function getString(number) {
    const strList4c = strList();
    return getString = function(index) {
            index = index - 0x1a6;
            return strList4c[index];
        },
        getString(number);
}

function code(v, k) {
    let y = v[0];
    let z = v[1];
    const delta = 0x9e3779b9,
        limit = delta * 0x20;
    let sum = 0x0;
    while (sum != limit) {
        y += (((z << 0x4) ^ (z >>> 0x5)) + z) ^ (sum + k[sum & 0x3]);
        sum += delta;
        z += (((y << 0x4) ^ (y >>> 0x5)) + y) ^ (sum + k[(sum >>> 0xb) & 0x3]);
    }
    v[0] = y;
    v[1] = z;
}

function Str4ToLong(string) {
    let _0x283da9 = 0;
    for (let i = 0; i < 4; i++)
        _0x283da9 |= string[getString(0x1ac)](i) << i * 8;
    return isNaN(_0x283da9) ? 0 : _0x283da9;
}

function LongToBase16(longint) {
    let s = '';
    for (let i = 3; i >= 0; i--) {
        let _0x43811c = (longint >> 8 * i & 0xff)['toString'](0x10);
        if (parseInt('0x' + _0x43811c) <= 15)
            _0x43811c = '0' + _0x43811c;
        s += _0x43811c;
    }
    return s;
}

function Base16ToLong(_0x203413) {
    let _0x48728d = 0x0;
    for (let i = 0x0; i < 0x8; i += 0x2) {
        let _0x24e56c = parseInt('0x' + _0x203413[getString(0x1a6)](i, i + 0x2));
        _0x48728d = (_0x48728d << 0x8) + _0x24e56c;
    }
    return _0x48728d;
}

function strList() {
    const strlist = ['encrypt',
        '33MGcQht', '6fbde674819a59bfa12092565b4ca2a7a11dc670c678681daf4afb6704b82f0c',
        '14021KbbewD', 'charCodeAt', '808heYYJt', '5DlyrGX', '552oZzIQH',
        'fromCharCode', '356IjESGA', '784713mdLTBv', '2529060PvKScd', '805548mjjthm',
        '844848vFCypf', '4bIkkcJ', '1356853149054377', 'length',
        'slice', '1720848ZSQDkr'
    ];
    strList = function() {
        return strlist;
    };
    return strList();
}

function LongToStr4(longint) {
    _0x106afc = String[getString(0x1b0)](longint & 0xff, longint >> 0x8 & 0xff, longint >> 0x10 & 0xff, longint >> 0x18 & 0xff);
    return _0x106afc;
}

function gyflagh(input) {
    let cipher = input[getString(0x1a8)](getString(0x1b7));
    if (cipher === getString(0x1aa))
        return true;
    return false;
}
```

其实有经验的选手在看到 `0x9e3779b9` 就已经警觉了。当然没经验的选手也可以通过代码逻辑看出来。

观察代码可以发现，最前面的函数对于 `strlist` 进行了顺序的修改，可以直接尝试通过 console 打印出打乱以后的 `strlist`：

例如：

```
> getString(0x1a8)
> 'encrypt'
```

然后继续还原代码

```javascript
String.prototype.encrypt = function(password) {
    const v = new Array(2);
    const k = new Array(4);
    let s = '';
    plaintext = escape(this);
    for (var i = 0; i < 4; i++)
        k[i] = Str4ToLong(password.slice(i * 4, (i + 1) * 4));
    for (i = 0; i < plaintext.length; i += 8) {
        v[0] = Str4ToLong(plaintext.slice(i, i + 4));
        v[1] = Str4ToLong(plaintext.slice(i + 4, i + 8));
        code(v, k);
        s += LongToBase16(v[0]) + LongToBase16(v[1]);
    }
    return s;
}
function code(v, k) {
    let y = v[0];
    let z = v[1];
    const delta = 0x9e3779b9,
        limit = delta * 0x20;
    let sum = 0;
    while (sum != limit) {
        y += (((z << 0x4) ^ (z >>> 0x5)) + z) ^ (sum + k[sum & 0x3]);
        sum += delta;
        z += (((y << 0x4) ^ (y >>> 0x5)) + y) ^ (sum + k[(sum >>> 0xb) & 0x3]);
    }
    v[0] = y;
    v[1] = z;
}

function Str4ToLong(string) {
    let _0x283da9 = 0;
    for (let i = 0; i < 4; i++)
        _0x283da9 |= string.charCodeAt(i) << i * 8;
    return isNaN(_0x283da9) ? 0 : _0x283da9;
}

function LongToBase16(longint) {
    let s = '';
    for (let i = 3; i >= 0; i--) {
        let _0x43811c = (longint >> 8 * i & 0xff)['toString'](0x10);
        if (parseInt('0x' + _0x43811c) <= 15)
            _0x43811c = '0' + _0x43811c;
        s += _0x43811c;
    }
    return s;
}

function Base16ToLong(base16) {
    let _0x48728d = 0x0;
    for (let i = 0x0; i < 0x8; i += 0x2) {
        let _0x24e56c = parseInt('0x' + base16.slice(i, i + 0x2));
        _0x48728d = (_0x48728d << 0x8) + _0x24e56c;
    }
    return _0x48728d;
}

function strList() {
    const strlist = ['encrypt',
        '33MGcQht', '6fbde674819a59bfa12092565b4ca2a7a11dc670c678681daf4afb6704b82f0c',
        '14021KbbewD', 'charCodeAt', '808heYYJt', '5DlyrGX', '552oZzIQH',
        'fromCharCode', '356IjESGA', '784713mdLTBv', '2529060PvKScd', '805548mjjthm',
        '844848vFCypf', '4bIkkcJ', '1356853149054377', 'length',
        'slice', '1720848ZSQDkr'
    ];
    strList = function() {
        return strlist;
    };
    return strList();
}

function LongToStr4(longint) {
    _0x106afc = String.fromCharCode(longint & 0xff, longint >> 0x8 & 0xff, longint >> 0x10 & 0xff, longint >> 0x18 & 0xff);
    return _0x106afc;
}

function gyflagh(input) {
    let cipher = input.encrypt('1356853149054377');
    if (cipher === '6fbde674819a59bfa12092565b4ca2a7a11dc670c678681daf4afb6704b82f0c')
        return true;
    return false;
}
```

到这里已经非常明确了，这里其实是一个 TEA 加密，密钥是 `1356853149054377`，加密结果是 `6fbde674819a59bfa12092565b4ca2a7a11dc670c678681daf4afb6704b82f0c`

可以解密得到 `McWebRE_inMlnCrA1t_3a5y_1cIuop9i`，按照提示加上 `flag{}` 就可以得到最终的 flag。

### 吐槽

出完以后说实话我感觉不太好。因为本体的核心考察点和 Minecraft 并无任何联系，主要是最近在玩这个所以直接拿来用了……（有一种产品包装和内容不符的既视感？orz），不过纯静态的网站替运维省了不少麻烦。

难度上，其实应该算 200-250 分的题比较合理，以后再出题的话难度把握还得考量考量。
