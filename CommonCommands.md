# Ethereum常用命令

## geth命令

1. 命令行参数

   ```
   geth --help
   NAME:
      geth - the go-ethereum command line interface

      Copyright 2013-2017 The go-ethereum Authors

   USAGE:
      geth [options] command [command options] [arguments...]
      
   VERSION:
      1.8.3-stable-329ac18e
      
   COMMANDS:
      account           Manage accounts
      attach            Start an interactive JavaScript environment (connect to node)
      bug               opens a window to report a bug on the geth repo
      console           Start an interactive JavaScript environment
      copydb            Create a local chain from a target chaindata folder
      dump              Dump a specific block from storage
      dumpconfig        Show configuration values
      export            Export blockchain into file
      export-preimages  Export the preimage database into an RLP stream
      import            Import a blockchain file
      import-preimages  Import the preimage database from an RLP stream
      init              Bootstrap and initialize a new genesis block
      js                Execute the specified JavaScript files
      license           Display license information
      makecache         Generate ethash verification cache (for testing)
      makedag           Generate ethash mining DAG (for testing)
      monitor           Monitor and visualize node metrics
      removedb          Remove blockchain and state databases
      version           Print version numbers
      wallet            Manage Ethereum presale wallets
      help, h           Shows a list of commands or help for one command
      
   ETHEREUM OPTIONS:
     --config value                      TOML configuration file
     --datadir "/home/ubuntu/.ethereum"  Data directory for the databases and keystore
     --keystore                          Directory for the keystore (default = inside the datadir)
     --nousb                             Disables monitoring for and managing USB hardware wallets
     --networkid value                   Network identifier (integer, 1=Frontier, 2=Morden (disused), 3=Ropsten, 4=Rinkeby) (default: 1)
     --testnet                           Ropsten network: pre-configured proof-of-work test network
     --rinkeby                           Rinkeby network: pre-configured proof-of-authority test network
     --syncmode "fast"                   Blockchain sync mode ("fast", "full", or "light")
     --gcmode value                      Blockchain garbage collection mode ("full", "archive") (default: "full")
     --ethstats value                    Reporting URL of a ethstats service (nodename:secret@host:port)
     --identity value                    Custom node name
     --lightserv value                   Maximum percentage of time allowed for serving LES requests (0-90) (default: 0)
     --lightpeers value                  Maximum number of LES client peers (default: 100)
     --lightkdf                          Reduce key-derivation RAM & CPU usage at some expense of KDF strength
     
   DEVELOPER CHAIN OPTIONS:
     --dev               Ephemeral proof-of-authority network with a pre-funded developer account, mining enabled
     --dev.period value  Block period to use in developer mode (0 = mine only if transaction pending) (default: 0)
     
   ETHASH OPTIONS:
     --ethash.cachedir                       Directory to store the ethash verification caches (default = inside the datadir)
     --ethash.cachesinmem value              Number of recent ethash caches to keep in memory (16MB each) (default: 2)
     --ethash.cachesondisk value             Number of recent ethash caches to keep on disk (16MB each) (default: 3)
     --ethash.dagdir "/home/ubuntu/.ethash"  Directory to store the ethash mining DAGs (default = inside home folder)
     --ethash.dagsinmem value                Number of recent ethash mining DAGs to keep in memory (1+GB each) (default: 1)
     --ethash.dagsondisk value               Number of recent ethash mining DAGs to keep on disk (1+GB each) (default: 2)
     
   TRANSACTION POOL OPTIONS:
     --txpool.nolocals            Disables price exemptions for locally submitted transactions
     --txpool.journal value       Disk journal for local transaction to survive node restarts (default: "transactions.rlp")
     --txpool.rejournal value     Time interval to regenerate the local transaction journal (default: 1h0m0s)
     --txpool.pricelimit value    Minimum gas price limit to enforce for acceptance into the pool (default: 1)
     --txpool.pricebump value     Price bump percentage to replace an already existing transaction (default: 10)
     --txpool.accountslots value  Minimum number of executable transaction slots guaranteed per account (default: 16)
     --txpool.globalslots value   Maximum number of executable transaction slots for all accounts (default: 4096)
     --txpool.accountqueue value  Maximum number of non-executable transaction slots permitted per account (default: 64)
     --txpool.globalqueue value   Maximum number of non-executable transaction slots for all accounts (default: 1024)
     --txpool.lifetime value      Maximum amount of time non-executable transaction are queued (default: 3h0m0s)
     
   PERFORMANCE TUNING OPTIONS:
     --cache value            Megabytes of memory allocated to internal caching (default: 1024)
     --cache.database value   Percentage of cache memory allowance to use for database io (default: 75)
     --cache.gc value         Percentage of cache memory allowance to use for trie pruning (default: 25)
     --trie-cache-gens value  Number of trie node generations to keep in memory (default: 120)
     
   ACCOUNT OPTIONS:
     --unlock value    Comma separated list of accounts to unlock
     --password value  Password file to use for non-interactive password input
     
   API AND CONSOLE OPTIONS:
     --rpc                  Enable the HTTP-RPC server
     --rpcaddr value        HTTP-RPC server listening interface (default: "localhost")
     --rpcport value        HTTP-RPC server listening port (default: 8545)
     --rpcapi value         API's offered over the HTTP-RPC interface
     --ws                   Enable the WS-RPC server
     --wsaddr value         WS-RPC server listening interface (default: "localhost")
     --wsport value         WS-RPC server listening port (default: 8546)
     --wsapi value          API's offered over the WS-RPC interface
     --wsorigins value      Origins from which to accept websockets requests
     --ipcdisable           Disable the IPC-RPC server
     --ipcpath              Filename for IPC socket/pipe within the datadir (explicit paths escape it)
     --rpccorsdomain value  Comma separated list of domains from which to accept cross origin requests (browser enforced)
     --rpcvhosts value      Comma separated list of virtual hostnames from which to accept requests (server enforced). Accepts '*' wildcard. (default: "localhost")
     --jspath loadScript    JavaScript root path for loadScript (default: ".")
     --exec value           Execute JavaScript statement
     --preload value        Comma separated list of JavaScript files to preload into the console
     
   NETWORKING OPTIONS:
     --bootnodes value     Comma separated enode URLs for P2P discovery bootstrap (set v4+v5 instead for light servers)
     --bootnodesv4 value   Comma separated enode URLs for P2P v4 discovery bootstrap (light server, full nodes)
     --bootnodesv5 value   Comma separated enode URLs for P2P v5 discovery bootstrap (light server, light nodes)
     --port value          Network listening port (default: 30303)
     --maxpeers value      Maximum number of network peers (network disabled if set to 0) (default: 25)
     --maxpendpeers value  Maximum number of pending connection attempts (defaults used if set to 0) (default: 0)
     --nat value           NAT port mapping mechanism (any|none|upnp|pmp|extip:<IP>) (default: "any")
     --nodiscover          Disables the peer discovery mechanism (manual peer addition)
     --v5disc              Enables the experimental RLPx V5 (Topic Discovery) mechanism
     --netrestrict value   Restricts network communication to the given IP networks (CIDR masks)
     --nodekey value       P2P node key file
     --nodekeyhex value    P2P node key as hex (for testing)
     
   MINER OPTIONS:
     --mine                    Enable mining
     --minerthreads value      Number of CPU threads to use for mining (default: 2)
     --etherbase value         Public address for block mining rewards (default = first account created) (default: "0")
     --targetgaslimit value    Target gas limit sets the artificial target gas floor for the blocks to mine (default: 4712388)
     --gasprice "18000000000"  Minimal gas price to accept for mining a transactions
     --extradata value         Block extra data set by the miner (default = client version)
     
   GAS PRICE ORACLE OPTIONS:
     --gpoblocks value      Number of recent blocks to check for gas prices (default: 20)
     --gpopercentile value  Suggested gas price is the given percentile of a set of recent transaction gas prices (default: 60)
     
   VIRTUAL MACHINE OPTIONS:
     --vmdebug  Record information useful for VM and contract debugging
     
   LOGGING AND DEBUGGING OPTIONS:
     --metrics                 Enable metrics collection and reporting
     --fakepow                 Disables proof-of-work verification
     --nocompaction            Disables db compaction after import
     --verbosity value         Logging verbosity: 0=silent, 1=error, 2=warn, 3=info, 4=debug, 5=detail (default: 3)
     --vmodule value           Per-module verbosity: comma-separated list of <pattern>=<level> (e.g. eth/*=5,p2p=4)
     --backtrace value         Request a stack trace at a specific logging statement (e.g. "block.go:271")
     --debug                   Prepends log messages with call-site location (file and line number)
     --pprof                   Enable the pprof HTTP server
     --pprofaddr value         pprof HTTP server listening interface (default: "127.0.0.1")
     --pprofport value         pprof HTTP server listening port (default: 6060)
     --memprofilerate value    Turn on memory profiling with the given rate (default: 524288)
     --blockprofilerate value  Turn on block profiling with the given rate (default: 0)
     --cpuprofile value        Write CPU profile to the given file
     --trace value             Write execution trace to the given file
     
   WHISPER (EXPERIMENTAL) OPTIONS:
     --shh                       Enable Whisper
     --shh.maxmessagesize value  Max message size accepted (default: 1048576)
     --shh.pow value             Minimum POW accepted (default: 0.2)
     
   DEPRECATED OPTIONS:
     --fast   Enable fast syncing through state downloads
     --light  Enable light client mode
     
   MISC OPTIONS:
     --help, -h  show help
     

   COPYRIGHT:
      Copyright 2013-2017 The go-ethereum Authors
   ```

   ​

2. attach用法

   ```
   geth --ipcpath ~/.ethereum/geth.ipc attach  #指定本地ipc文件方式
   geth attach ethereum/data1/geth.ipc   #指定连接ipc
   geth --exec 'eth.coinbase' attach http://172.16.0.10:8545  #指定HTTP的ipc接口，并执行命令
   ```

   ​

3. 使用密码文件自动解锁账号

   ```
   --unlock '0,1,2' --password ~/.ethereum/password  #password文件中明码顺序书写密码
   ```

   ​

4. 启动rpc接口
   在geth命令行追加参数启动rpc服务：

   ```
   --rpc --rpcaddr="0.0.0.0" --rpcport 8001 --rpccorsdomain="*" --rpcapi="db,eth,net,web3,personal"
   ```

   ​

5. 加载并运行JS文件

   ```
   geth --jspath "/tmp" --exec 'loadScript("checkbalances.js")' attach http://123.123.123.123:8545	
   ```

   ​

6. 挖矿

   ```
   geth --mine --minerthreads=2 --etherbase=0x83fda0ba7e6cfa8d7319d78fa0e6b753a2bcb5a6
   ```

   ​

7. 日志和后台运行

   geth没有设置成后台daemon（https://github.com/ethereum/go-ethereum/issues/2607），因此不能通过nohup之类启动到后台，如果需要后台，需要使用screen或者docker方式进行处理。

   ​

8. JS控制台常用命令

   ```javascript
   personal.newAccount("123456") #创建账号
   personal.listAccounts #列出账号
   personal.listAccounts[1]
   eth.accounts
   eth.accounts[0]

   personal.unlockAccount(eth.accounts[0],"password", 1000*60*20) #解锁账号20分钟

   eth.coinbase 旷工账号

   eth.getBalance(eth.accounts[0]) #查看账号余额
   web3.fromWei(eth.getBalance(eth.accounts[0]), "ether") #以以太币格式查找余额

   #可以JS方式定义变量和函数
   function checkAllBalances() {
     web3.eth.getAccounts(function(err, accounts) {
      accounts.forEach(function(id) {
       web3.eth.getBalance(id, function(err, balance) {
        console.log("" + id + ":\tbalance: " + web3.fromWei(balance, "ether") + " ether");
      });
     });
    });
   };	

   #运行函数
   checkAllBalances()

   #转账
   personal.unlockAccount("0x83fda0ba7e6cfa8d7319d78fa0e6b753a2bcb5a6", "", 300)	
   eth.sendTransaction({from: '0x83fda0ba7e6cfa8d7319d78fa0e6b753a2bcb5a6', to: '0xe8abf98484325fd6afc59b804ac15804b978e607', value: web3.toWei(1, "ether")})

   #状态
   eth.pendingTransactions  #查看挂起的交易
   eth.blockNumber #查看最后的区块ID
   eth.getBlock(1)  #查看区块信息

   #查看智能合约编译器
   eth.compile

   #以太币单位，默认是最小的单位Wei
   kwei (1000 Wei)
   mwei (1000 KWei)
   gwei (1000 mwei)
   szabo (1000 gwei)
   finney (1000 szabo)
   ether (1000 finney)

   web3.fromWei(10000000000000000,"ether") #单位转换

   #查看网络ID
   admin.nodeInfo.protocols.eth.network
   #手工加入节点
   admin.addPeer()
   net.listening
   admin.nodeInfo
   admin.nodeInfo.enode
   admin.addPeer('enode://322de50135b1542f17585e73aea7ffe9585e9d988cecdff40732842113e5cdb9ae249ca3b12fe7658101632bfc5e19493acf941d9a52a2a9f16627318f01e76d@10.20.1.13:30303')
   net.peerCount
   admin.peers
   admin.peers.forEach(function(p) {console.log(p.network.remoteAddress);})

   #挖矿
   miner.setEtherbase("0x83fda0ba7e6cfa8d7319d78fa0e6b753a2bcb5a6")  #设置默认矿工账号地址
   eth.accounts
   eth.coinbase
   miner.start(1)  #一个进程开始挖矿
   miner.stop()

   #txpool管理
   txpool.status

   amount = web3.toWei(5,'ether')
   eth.sendTransaction({from:eth.accounts[0],to:eth.accounts[1],value:amount})	
   txpool.status 
   miner.start(1);admin.sleepBlocks(1);miner.stop();
   txpool.status
   web3.fromWei(eth.getBalance(eth.accounts[1]),'ether')  
   ```

   ​



## Mac下使用客户端钱包（Ethereum Wallet）

下载安装以太坊钱包

https://github.com/ethereum/mist/releases

钱包默认是连接到下面地址。

```
IPC endpoint opened: /Users/${User}/Library/Ethereum/geth.ipc
```

连接到其他本地geth启动的ipc地址

```
"/Applications/Ethereum Wallet.app/Contents/MacOS/Ethereum Wallet" --rpc /Users/other/Library/Ethereum/geth.ipc
```

如果需要连接到远程节点上，需要使用命令行，方法如下。启动钱包并连接到远程开发环境，localhost 改为你的IP地址即可。

```
"/Applications/Ethereum Wallet.app/Contents/MacOS/Ethereum Wallet" --rpc http://localhost:8545							
```
TODO： 需要分析Mist的程序开发框架、代码结构和定制开发方法。



## 一个SSH终端下面使用screen命令进行快速验证的常用操作命令

```
screen -S geth  #启动一个geth验证的screen回话
ctrl-a d #临时退出这个回话
screen -r geth  #恢复geth验证的screen回话
C-a z    #临时把当前回话放到后台，使用fg命令可以快速回来

C-a c    #创建一个新shell窗口
C-a n / p / 0..9 / [SPACE] / C-a / w  #切换窗口
C-a A    #为当前窗口命名
C-a k    #关闭当前窗口，杀死窗口的进程

C-a S  #将显示器水平分割
C-a |  #将显示器垂直分屏
C-a <tab>  #在各个区之间切换
C-a X      #关闭当前焦点所在的屏幕区块(窗口不会关闭)
C-a Q      #关闭除当前区块之外其他的所有区块(窗口不会关闭)
```

