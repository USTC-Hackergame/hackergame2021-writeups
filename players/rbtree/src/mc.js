function Str4ToLong(str) 
{
    let value = 0x0;
    for (let i = 0; i < 4; i++) 
        value |= str.charCodeAt(i) << (i * 8);
    return isNaN(value) ? 0 : value;
}

function code(text, key) 
{
    const c = 0x9E3779B9,
        d = c * 32; // 84941944608
    let v = 0;
    while (v != d) {
        text[0] += (((text[1] << 0x4) ^ (text[1] >>> 0x5)) + text[1]) ^ (v + key[v & 0x3]);
        v += c;
        text[1] += (((text[0] << 0x4) ^ (text[0] >>> 0x5)) + text[0]) ^ (v + key[(v >>> 11) & 0x3]);
    }
    return text;
}

function decode(text, key) 
{
    const c = 0x9E3779B9,
        d = 0; // 84941944608
    let v = c * 32;
    while (v != d) {
        text[0] -= (((text[1] << 0x4) ^ (text[1] >>> 0x5)) + text[1]) ^ (v + key[v & 0x3]);
        v -= c;
        text[1] -= (((text[0] << 0x4) ^ (text[0] >>> 0x5)) + text[0]) ^ (v + key[(v >>> 11) & 0x3]);
    }
    return text;
}


function LongToBase16(value) {
    let result = "";
    for (let i = 3; i >= 0; i--) {
        let tempStr = ((value >> (0x8 * i)) & 0xff)["toString"](0x10);
        if (parseInt("0x" + tempStr) <= 0xf) 
            tempStr = "0" + tempStr;
        result += tempStr;
    }
    return result;
}


function encrypt(self, keyString) 
{
    const plain = new Array(2);
    const key = new Array(4);
    let chiper = "";

    plaintext = escape(self);

    for (var i = 0; i < 4; i++) {
        key[i] = Str4ToLong(keyString.slice(i * 4, (i + 1) * 4));
    }

    console.log(key);

    for (i = 0; i < plaintext.length; i += 8) {
        plain[0] = Str4ToLong(plaintext.slice(i, i + 4));
        plain[1] = Str4ToLong(plaintext.slice(i + 4, i + 8));

        console.log(i)
        console.log("\tkey: " + key)
        console.log("\tplainbefore: " + plain)

        code(plain, key);

        console.log("\tplainafter: " + plain)

        chiper += LongToBase16(plain[0]) + LongToBase16(plain[1]);
    }
    return chiper;
}


keys = [909456177, 825439544, 892352820, 926364468]

value1 = [0x6fbde674,0x819a59bf]
value2 = [0xa1209256,0x5b4ca2a7]
value3 = [0xa11dc670,0xc678681d]
value4 = [0xaf4afb67,0x04b82f0c]

