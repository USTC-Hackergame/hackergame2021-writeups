# 链上预言家

题解作者：[zzh1996](https://github.com/zzh1996)

出题人、验题人、文案设计等：见 [Hackergame 2021 幕后工作人员](../../credits.pdf)。

## 题目描述

- 题目分类：general

- 题目分值：预测已知（200）+ 预测未知（250）

- 题目链接：[http://202.38.93.111:10101/?token={token}](http://202.38.93.111:10101/)

「看，我可以预测你创建的以太坊智能合约的地址，然后[向每个地址转账 114514 wei](https://cn.etherscan.com/tx/0x51ae3234322a57787c1b58432eff1c8a80fb2dd8d0639a73be3e4ea8bea2d5cf)。」（此链接与本题解法无关）

「太过分了！我以后要用 **CREATE2** 来创建我的智能合约，并且用随机数作为种子，这样地址就不会被你提前猜到了。」

「猜不到是不可能的，不仅我可以猜到，我写的智能合约都可以猜到，不信你看看。」

**[下载题目源代码](src/链上预言家.zip)**

你可以通过 `nc 202.38.93.111 10100` 来连接，也可以点击下面按钮打开网页终端。

> 如果你不知道 `nc` 是什么，或者在使用上面的命令时遇到了困难，可以参考我们编写的 [萌新入门手册：如何使用 nc/ncat？](https://lug.ustc.edu.cn/planet/2019/09/how-to-use-nc/)

## 题解

### 预测已知

题目合约：

```solidity
pragma solidity =0.8.9;

interface Predictor {
    function predict(address challenge) external returns (address);
}

contract Dummy {
    function hello() public pure returns (string memory) {
        return "Hello!";
    }
}

contract Challenge {
    bytes32 public seed;

    constructor(bytes32 _seed) {
        seed = _seed;
    }

    function create_child() public returns (address) {
        return address(new Dummy{salt:seed}());
    }

    function predict_child(Predictor p) public returns (bool) {
        address predicted = p.predict(address(this));
        address real = create_child();
        return predicted == real;
    }
}
```

第一问比较简单，需要选手提交一个智能合约的字节码，这个智能合约要实现一个 `predict` 函数，用来预测题目合约创建的子合约的地址。做过智能合约题目的选手应该都可以解出来吧。（为什么解出人数这么少？2019 年我出的「[韭菜银行](https://github.com/ustclug/hackergame2019-writeups/blob/master/official/%E9%9F%AD%E8%8F%9C%E9%93%B6%E8%A1%8C/README.md)」题目解出人数都比这道题多很多）

题目中提示了 [CREATE2](https://eips.ethereum.org/EIPS/eip-1014)，通过 CREATE2 创建的智能合约地址是可以确定性计算出来的，根据 CREATE2 的 EIP，地址的计算公式是：

`keccak256( 0xff ++ address ++ salt ++ keccak256(init_code))[12:]`

甚至可以很容易查到 [Solidity 语言中如何计算 CREATE2 地址](https://solidity-by-example.org/app/create2/)。

公式中 `address` 就是题目合约的地址，已经作为参数传给你的合约了（并且每次运行它都不会变）。

`salt` 就是题目合约中那个 `bytes32 public seed`，是公开变量，可以通过调用题目合约的 `seed()` 来查询。

`init_code` 是 Dummy 合约的字节码，想获取它可以自己编译，也可以从 Challenge 的字节码中抠出来，还可以在题目服务器上通过 revert 的报错信息来泄露出来。

如果自己编译的话，要注意合约的字节码最后有一段 Hash，[其中包括源代码相关的 metadata](https://docs.soliditylang.org/en/latest/metadata.html)，例如源代码文件名。所以一定要使用题目源代码中提供的编译方法来编译，否则这个 Hash 会不一样。

获取到的 Dummy 合约的字节码如下：

```
608060405234801561001057600080fd5b5061017c806100206000396000f3fe608060405234801561001057600080fd5b506004361061002b5760003560e01c806319ff1d2114610030575b600080fd5b61003861004e565b6040516100459190610124565b60405180910390f35b60606040518060400160405280600681526020017f48656c6c6f210000000000000000000000000000000000000000000000000000815250905090565b600081519050919050565b600082825260208201905092915050565b60005b838110156100c55780820151818401526020810190506100aa565b838111156100d4576000848401525b50505050565b6000601f19601f8301169050919050565b60006100f68261008b565b6101008185610096565b93506101108185602086016100a7565b610119816100da565b840191505092915050565b6000602082019050818103600083015261013e81846100eb565b90509291505056fea2646970667358221220d65c19c2e3411473f3d909b5c1ceaa44b64961c56ca58c247accae052461048364736f6c63430008090033
```

所以解题合约可以如下写出：

```solidity
pragma solidity =0.8.9;

interface Challenge {
    function seed() external returns (bytes32);
}

contract Hack {
    function predict(address challenge) external returns (address) {
        return address(uint160(uint(keccak256(
            abi.encodePacked(bytes1(0xff), challenge, Challenge(challenge).seed(), keccak256(hex"608060405234801561001057600080fd5b5061017c806100206000396000f3fe608060405234801561001057600080fd5b506004361061002b5760003560e01c806319ff1d2114610030575b600080fd5b61003861004e565b6040516100459190610124565b60405180910390f35b60606040518060400160405280600681526020017f48656c6c6f210000000000000000000000000000000000000000000000000000815250905090565b600081519050919050565b600082825260208201905092915050565b60005b838110156100c55780820151818401526020810190506100aa565b838111156100d4576000848401525b50505050565b6000601f19601f8301169050919050565b60006100f68261008b565b6101008185610096565b93506101108185602086016100a7565b610119816100da565b840191505092915050565b6000602082019050818103600083015261013e81846100eb565b90509291505056fea2646970667358221220d65c19c2e3411473f3d909b5c1ceaa44b64961c56ca58c247accae052461048364736f6c63430008090033"))
        ))));
    }
}
```

至于如何把智能合约源代码编译成字节码，可以参考题目源代码中的编译脚本，也可以直接用在线的 [Remix IDE](https://remix.ethereum.org/)。

### 预测未知

这一问很有趣，`seed` 变量变为了 private 变量，其他部分跟第一问完全一样。无论你怎么尝试，一个合约都不可能读到另一个合约的私有变量。（当然，私有变量并不私密，在公开的区块链上，任何人都可以直接读取私有变量的值。）

如果你调用题目合约的 `create_child` 函数，可以得到子合约的地址，但是这时子合约已经创建了，当判题函数 `predict_child` 再次调用 `create_child` 时，目标地址上已经有智能合约了，所以会失败，导致无法通过检查。

调用 `create_child` 函数才能得到子合约的地址，但是我们却不希望子合约被真的创建出来，怎么办呢？

答案是使用 `revert` 来回滚 `create_child` 的调用，然后想办法把得到的地址“偷”出来。

在 EVM 中，一个 call 被 revert 的时候，它产生的所有副作用都会回滚，就跟无事发生过一样（除了消耗 gas）。

由于我们不能让 `create_child` 自己 revert，所以我们要把它包在一个函数里然后主动 revert。

EVM 中，一个 call 被 revert 的时候，你可以忽略这个错误，然后继续执行，而且 revert 可以返回错误信息。在 Solidity 中，函数调用的默认行为是，被调用的函数 revert，会导致调用的函数也 revert。如果我们不想写内联汇编，那么可以通过 low-level call 或者 [try-catch](https://docs.soliditylang.org/en/latest/control-structures.html#try-catch) 的方式来忽略 revert 错误。

这里使用 try-catch 来解题：

```solidity
pragma solidity =0.8.9;

interface Challenge {
    function create_child() external returns (address);
}

contract Hack {
    function predict(address challenge) external returns (address) {
        try this.revert_with_child_address(challenge) {
        } catch Error(string memory reason) {
            return abi.decode(bytes(reason), (address));
        }
    }

    function revert_with_child_address(address challenge) public {
        address a = Challenge(challenge).create_child();
        revert(string(abi.encode(a)));
    }
}
```
