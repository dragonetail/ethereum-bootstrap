# 智能合约（Token代币示例）

通过本文所述方法和项目中的脚本，可以快速的部署和测试智能合约示例。

仓库中包含的工具有：

* 一个合约样例：`Token.sol`。这是一个使用合约语言[Solidity](http://solidity.readthedocs.org/en/latest/)编写的智能合约。Token合约的功能是发行一种token（可以理解为货币，积分等等），只有合约的创建者有发行权，token的拥有者有使用权，并且可以自由转账。

## 准备

1. 完成了`1.SingleNode`的内容，并启动私有以太坊服务控制器，解锁缺省账号以部署合约：

   ```
   > personal.unlockAccount(web3.eth.accounts[0])
   ```

2. 将本仓库通过`git clone`命令下载到本地。

## 使用以太坊控制台编译和部署智能合约

进入本仓库目录: `cd ethereum-bootstrap/2.TokenContract`

目录下有一个智能合约样例文件`Token.sol`, 通过Solidity语言实现了基本的代币功能, 合约持有者可以发行代币, 使用者可以互相转账。

我们可以使用以太坊控制台来编译部署这个合约。以太坊控制台是最基本的工具，使用会比较繁琐。社区也提供了其他更加方便的部署工具，此处不做讨论。

先生成（编辑）一个编译合约的脚本：

``echo "var tokenCompiled=`solc --optimize --combined-json abi,bin,interface Token.sol`" > token.js``

在终端命令行执行后会生成一个token.js的文件。

切换到`cd ethereum-bootstrap/1.SingleNode`中进入以太坊控制台，把js文件加载进来，会生成一个tokenCompiled的JS变量:

```javascript
loadScript("../2.TokenContract/token.js")
```

通过`tokenCompiled.contracts["Token.sol:Token"].bin` 可以看到编译好的二进制代码，通过`tokenCompiled.contracts["Token.sol:Token"].abi`可以看到合约的[ABI](https://github.com/ethereum/wiki/wiki/Ethereum-Contract-ABI)．

以变量的形式取出合约的二进制代码和ABI。
```javascript
var tokenContractsBin = "0x" + tokenCompiled.contracts["Token.sol:Token"].bin;
var tokenContractsAbi = tokenCompiled.contracts["Token.sol:Token"].abi;
```

接下来我们要把编译好的合约部署到网络上去。

首先我们用ABI来创建一个javascript环境中的合约对象：

```javascript
var contract = web3.eth.contract(JSON.parse(tokenContractsAbi));
```

我们通过合约对象来部署合约：

```javascript
var initializer = {from: web3.eth.accounts[0], data: tokenContractsBin, gas: 300000};

var token = contract.new(initializer);
//这一步会出现 Error: authentication needed: password or unlock 错误，这个时候需要解锁账号之后再执行
// personal.unlockAccount(web3.eth.accounts[0])
```

```javascript
> var token = contract.new(initializer);
INFO [04-12|17:08:20] Submitted contract creation              fullhash=0xdac957a6e0a914b37d02b176a8d4fd2f9a26ce98146feed58fbeac6f801bc965 contract=0xC6E94741EccB04e50d42df821943eed07c74cdc4
//说明合约提交成功
```

`contract.new`方法的第一个参数设置了这个新合约的创建者地址`from`, 这个新合约的代码`data`, 和用于创建新合约的费用`gas`．`gas`是一个估计值，只要比所需要的gas多就可以，合约创建完成后剩下的gas会退还给合约创建者。

`contract.new`方法的第二个参数设置了一个回调函数，可以告诉我们部署是否成功（**？？？？**）

执行成功后，我们的合约Token就已经广播到网络上了。此时只要等待矿工把我们的合约打包保存到以太坊区块链上，部署就完成了。

在公有链上，矿工打包平均需要15秒，在私有链上，我们需要自己来做这件事情。首先开启挖矿：

```javascript
miner.start(1)
```

此时需要等待一段时间，以太坊节点会生成挖矿必须的数据，这些数据都会放到内存里面．在数据生成好之后，挖矿就会开始，稍后就能在控制台输出中看到类似：

```
:hammer:mined potential block
```

的信息，这说明挖到了一个块，合约已经部署到以太坊网络上了！此时我们可以把挖矿关闭：

```javascript
miner.stop()
```

接下来我们就可以调用合约了．先通过`token.address`获得合约部署到的地址，以后新建合约对象时可以使用。这里我们直接使用原来的contract对象：

```
// 本地钱包的第一个地址所持有的token数量
> token.getBalance(web3.eth.accounts[0])
0

// 发行100个token给本地钱包的第一个地址
> token.issue.sendTransaction(web3.eth.accounts[0], 100, {from: web3.eth.accounts[0]});
INFO [04-12|17:14:36] Submitted transaction                    fullhash=0x76c8077bb554d96349ef6a30994f04211aab455be03d688b2336e3fcefabab16 recipient=0xC6E94741EccB04e50d42df821943eed07c74cdc4
"0x76c8077bb554d96349ef6a30994f04211aab455be03d688b2336e3fcefabab16"

// 发行token是一个transaction, 因此需要挖矿使之生效
> miner.start(1)
:hammer:mined potential block
> miner.stop()

// 再次查询本地钱包第一个地址的token数量
> token.getBalance(web3.eth.accounts[0])
100

// 从第一个地址转30个token给本地钱包的第二个地址
> token.transfer.sendTransaction(web3.eth.accounts[1], 30, {from: web3.eth.accounts[0]})
INFO [04-12|17:15:28] Submitted transaction                    fullhash=0xcb81ef5b7920d8ace88aa5b69f188c914cb1243381fa8b3dc96157f063db9401 recipient=0xC6E94741EccB04e50d42df821943eed07c74cdc4
"0xcb81ef5b7920d8ace88aa5b69f188c914cb1243381fa8b3dc96157f063db9401"
> miner.start(1)
:hammer:mined potential block
> miner.stop()
> token.getBalance(web3.eth.accounts[0])
70
> token.getBalance(web3.eth.accounts[1])
30
```



