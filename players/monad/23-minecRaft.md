# minecRaft

打开网页，我们发现了一个微型 Minecraft 游戏，<del>然后就开始愉快的摸起鱼来</del>。

咳咳，这是一道 web 题，并且「本题解法与原版 Minecraft 游戏无关」。故 F12 打开，然后可以看到 html 内嵌的 js 中有这么一段：

```js
if (cinput.length >= 32) {
    let tbool = gyflagh(cinput.join(''));
    if (tbool) {
        pressplateList[65].TurnOn_redstone_lamp();
        content.innerText = 'Congratulations!!!';
        return;
    }
    cinput.length = 0;
}
```

并且 `gyflagh` 这个函数是定义在 `flag.js` 里面的，很难不猜测这就是最终涉及到 flag 的地方。

打开 `flag.js`，然后我们看到了一堆乱码…………

首先我们可以把 `0x` 打头的十六进制数转成十进制数，不然的话跟变量的命名很像，看着太瞎眼了。

然后观察一下参数是 `422` 到 `439` 之类的函数，可以发现都跟一个叫 `_0x2c9e` 的函数有关。

把这个 js 贴到 Devtools Console 里面，多执行几次，发现返回值不会变，并且都是 `charCodeAt`，`slice`, `fromCharCode` 这种函数名，不妨可以猜测这个函数只是一个 string mapping。所以我们就把这个 mapping 手动给它转回去。

替换完了之后，应该就只剩下变量名比较难看了。所以根据上下文，给这些变量换个名字。

这波操作下来之后，这个代码就好看了不少：

```js
String.prototype.encrypt = function(key_str) {
    const arr = new Array(2), key = new Array(4);
    let result = '';
    const plaintext = escape(this);
    for (var i = 0; i < 4; i++)
        key[i] = Str4ToLong(key_str.slice(i * 4, (i + 1) * 4));
    for (i = 0; i < plaintext.length; i += 8) {
        arr[0] = Str4ToLong(plaintext.slice(i    , i + 4));
        arr[1] = Str4ToLong(plaintext.slice(i + 4, i + 8));
        code(arr, key);
        result += LongToBase16(arr[0]) + LongToBase16(arr[1]);
    }
    return result;
};

function code(arr, key) {
    let a = arr[0], b = arr[1];
    const STEP = 2654435769, END = STEP * 32;
    let cur = 0;
    while (cur != END) {
        a += ((b << 4) ^ (b >>> 5)) + (b ^ cur) + key[cur & 3];
        cur += STEP;
        b += ((a << 4) ^ (a >>> 5)) + (a ^ cur) + key[(cur >>> 11) & 3];
    }
    arr[0] = a;
    arr[1] = b;
}

function Str4ToLong(val) {
    let result = 0;
    for (let i = 0; i < 4; i++)
        result |= val.charCodeAt(i) << (i * 8);
    return isNaN(result) ? 0 : result;
}

function LongToBase16(val) {
    let result = '';
    for (let i = 3; i >= 0; i--) {
        let tmp = ((val >> (8 * i)) & 0xff)['toString'](16);
        if (parseInt('0x' + tmp) <= 0xf)
            tmp = '0' + tmp;
        result += tmp;
    }
    return result;
}

function Base16ToLong(str) {
    let result = 0;
    for (let i = 0; i < 8; i += 2) {
        let tmp = parseInt('0x' + str.slice(i, i + 2));
        result = (result << 8) + tmp;
    }
    return result;
}

function LongToStr4(val) {
    return String.fromCharCode(val & 0xff, val >> 8 & 0xff, val >> 16 & 0xff, val >> 24 & 0xff);
}

function gyflagh(text) {
    let encrypted = text.encrypt('1356853149054377');
    return encrypted === '6fbde674819a59bfa12092565b4ca2a7a11dc670c678681daf4afb6704b82f0c';
}
```

我们先把目光放在 `String.prototype.encrypt` 上，这个函数首先将 `key_str` 分成了 4 段（`1356 8531 4905 4377`），然后将每一段通过 `Str4ToLong` 转为整数。

接着，再把 `text`（64 个字符，每 8 个分一段）分成 4 段，每一段中再分成前后两个部分（不妨称为 a, b），然后把 a, b 扔给 `code` 做变换，再把变换后的 a, b `LongToBase16` 后加到 `result`（字符串）后面。

上面这段话可能有点难理解，拿 `gyflagh` 中的例子来说，假设 `text = "mInecRaft#-ls_900d_f0r_$ntEr1ain"`，就是：

```
        Str4ToLong                   code                      LongToBase16

mIne cRaf  ->  1701726573 1717654115  -->   1874716276 -2120590913  ->  6fbde674 819a59bf
t#-l s_90  ->  1814897524 0809066355  -->  -1591700906  1531749031  ->  a1209256 5b4ca2a7
0d_f 0r_$  ->  1717527600 0610234928  -->  -1591884176  -965187555  ->  a11dc670 c678681d
ntEr 1ain  ->  1917154414 1852399921  -->  -1354040473    79179532  ->  af4afb67 04b82f0c
```

但是实际上，`text` 是什么我们是不知道的，我们要用 `encrypted` 来反推 `text`，其关键显然在 `code` 这个函数中。

然后现在的话，我们要完成的目标就是（右边的数值可以用 `encrypted` 进行 `Base16ToLong` 得到）：

```
code([?, ?], key)  ->   1874716276 -2120590913
code([?, ?], key)  ->  -1591700906  1531749031
code([?, ?], key)  ->  -1591884176  -965187555
code([?, ?], key)  ->  -1354040473    79179532
```

然后我们可以注意到，`code` 函数的计算是可逆的，可以通过最终的结果反推出输入的值。

于是随便写一个逆向程序：

```rust
const KEYS: [Wrapping<u32>; 4] = [ Wrapping(909456177), Wrapping(825439544), Wrapping(892352820), Wrapping(926364468) ];
const ADD: Wrapping<u32> = Wrapping(2654435769);

fn uncode(a: u32, b: u32) -> (u32, u32) {
    let mut val = ADD * Wrapping(32);

    let mut a = Wrapping(a);
    let mut b = Wrapping(b);

    for _i in 0..32 {
        b -= ((a << 4) ^ (a >> 5)) + a ^ val + KEYS[((val >> 11).0 & 3) as usize];
        val -= ADD;
        a -= ((b << 4) ^ (b >> 5)) + b ^ val + KEYS[(val.0 & 3) as usize];
    }

    return (a.0, b.0);
}
```

然后就不难推算出 `code` 的输入是：

```
[ 1700225869, 1598378594 ]
[ 1817013865, 1098007406 ]
[  861893681, 1601779041 ]
[ 1967743793, 1765372015 ]
```

然后再把这些值用 `LongToStr4` 拼回去，得到 `McWebRE_inMlnCrA1t_3a5y_1cIuop9i`。
