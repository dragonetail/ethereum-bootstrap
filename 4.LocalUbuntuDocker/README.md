# Mac本地Ubuntu环境配置Ethereum集群

远程使用云服务器，总是会有各种限制，因此本地使用Docker快速构建一套Ubuntu的环境，自由一些。

环境：

* Mac Pro
* Docker最新版
* Kitematic插件
* 下载Ubuntu最新镜像

## 开始

1. 使用Kitematic下载Ubuntu最新镜像，运行起来后执行exec启动终端。在终端中安装官方的ethereum安装包即可。

   ```shell
   注意：
   1、下载的镜像是最新版本，不是14.04；通过cat /etc/issue可以确认。
   Ubuntu 16.04.4 LTS \n \l (Ubuntu 16.04代号为Xenial Xerus)
   2、默认shell脚本不是bash，需要手工执行bash切换（这个是kitematic的设置，在设置中更改一下选择bash就OK了）。
   3、确认阿里支持的版本
   https://www.cnblogs.com/lyon2014/p/4715379.html
   http://mirrors.aliyun.com/ubuntu/dists/
   更改/etc/apt/sources.list
   root@geth-node01:~# cat /etc/apt/sources.list
   deb http://mirrors.aliyun.com/ubuntu/ xenial main multiverse restricted universe
   deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main multiverse restricted universe
   deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main multiverse restricted universe
   deb http://mirrors.aliyun.com/ubuntu/ xenial-security main multiverse restricted universe
   deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main multiverse restricted universe
   deb-src http://mirrors.aliyun.com/ubuntu/ xenial main multiverse restricted universe
   deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main multiverse restricted universe
   deb-src http://mirrors.aliyun.com/ubuntu/ xenial-proposed main multiverse restricted universe
   deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main multiverse restricted universe
   deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main multiverse restricted universe
   好吧，Docker环境不是拿来让我做为基础研究用的，基础的好多命令都没有，vi也没有，先用echo把上面第一行到sources.list中，先安装一下vim。
   还有经常用的telnet和ifocnfig肯定也没有，安装一下吧apt-get install telnet net-tools。
   另外，Docker环境缺省用户是root，不需要切换，也不需要sudo。

   然后执行
   apt-get update
   apt-get install software-properties-common
   add-apt-repository -y ppa:ethereum/ethereum
   apt-get update
   apt-get install ethereum solc git expect
   ```

2. 下载本教程的git库：

   ```
   cd /root
   git clone https://github.com/dragonetail/ethereum-bootstrap.git
   ```

3. 更改本地Docker的缺省网段：
   由于Docker缺省使用的是172.17.0.2网段，总是会有冲突，最好更改不常用的172.31.0.1/24会好些。
   mac下面很简单，通过图形界面就可以配置。
   如果是Ubuntu环境，则需要更改/etc/docker/daemon.json文件，追加下面：

   ```json
   {
     "registry-mirrors": ["https://0yy1bylx.mirror.aliyuncs.com"],
     "bip": "172.31.0.1/24"
   }
   ```

   改完重启Docker服务，然后进入docker实例中，ifconfig就可以发现地址改了。

4. 清除apt-get下载的缓存数据，apt-get clean

5. Mac命令行使用Docker命令行封装一个镜像，作为后面工作的基础镜像。

   ```
    docker ps -a #查看之前实例的ID
    docker commit -a "dragoentail" -m "Ethereum base image" bba539a5484c ubuntu:ethereum
    docker images
   REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
   ubuntu              ethereum            9be80fc84ace        About a minute ago   611MB
   ubuntu              latest              c9d990395902        2 days ago           113MB
   ```

   创建可新的镜像，kitematic里面同步有些问题，需要重新彻底启动后才能显现我们新创建的镜像。

6. 用我们的镜像创建两个实例node1和node2，然后也可以删除之前的ubuntu实例了。

7. 用我们【[3.LocalNetworkCluster](./3.LocalNetworkCluster/)：本地网络集群】的内容重新来一遍吧。

8. 好吧，ping命令也没有，需要的安装apt-get install inetutils-ping。

9. 操作内容记录：

   ```shell
   # 1、bootnode
   # node1实例上：
   cd ~/ethereum-bootstrap/3.LocalNetworkCluster/
   mkdir bootnode
   cd bootnode
   bootnode --genkey=boot.key
   bootnode --nodekey=boot.key
   enode://c389b58f8376837f8b24da99f9fa0cdb236b97e2311b6e0058ecb69f1d73fd57838c07fea92d1c03daeb5d24769b14098c48295ace528e9f716c393e2b148938@172.31.0.2:30301

   # 2、node1
   # node1实例上，重新启动一个终端窗口：
   cd ~/ethereum-bootstrap/3.LocalNetworkCluster/
   mkdir node1
   cd node1
   geth --datadir data --networkid 20180412  init ../genesis.json
   tar cvzf data.tar.gz data
   # 启动节点
   geth --datadir ./data --networkid 20180412 --bootnodes=enode://c389b58f8376837f8b24da99f9fa0cdb236b97e2311b6e0058ecb69f1d73fd57838c07fea92d1c03daeb5d24769b14098c48295ace528e9f716c393e2b148938@172.31.0.2:30301 --port 30303 console

   # 3、node2
   # node2实例上，重新启动一个终端窗口：
   cd ~/ethereum-bootstrap/3.LocalNetworkCluster/
   mkdir node2
   cd node2
   # 在宿主机上终端（本地Mac终端），使用Docker命令拷贝data.tar.gz到node2上：
   docker ps
   CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
   5961fc088979        ubuntu:ethereum     "/bin/bash"         22 minutes ago      Up 22 minutes                           node2
   33e9b21a031a        ubuntu:ethereum     "/bin/bash"         23 minutes ago      Up 23 minutes                           node1
   # 从node1拷贝文件到本地
   docker cp node1:/root/ethereum-bootstrap/3.LocalNetworkCluster/node1/data.tar.gz .
   # 拷贝文件到node2
   docker cp data.tar.gz node2:/root/ethereum-bootstrap/3.LocalNetworkCluster/node2/
   # 切换到node2的终端，查看文件
   ls -ltrh
   total 4.0K
   -rw-r--r-- 1 501 dialout 2.1K Apr 15 03:49 data.tar.gz
   # 解开文件
   tar xvzf data.tar.gz
   # 启动节点
   geth --datadir ./data --networkid 20180412 --bootnodes=enode://c389b58f8376837f8b24da99f9fa0cdb236b97e2311b6e0058ecb69f1d73fd57838c07fea92d1c03daeb5d24769b14098c48295ace528e9f716c393e2b148938@172.31.0.2:30301 --port 30303 console

   # 4、验证
   # 参照【3.LocalNetworkCluster：本地网络集群】
   # 导入genesis.json中生成的Key
   cat 1.SingleNode/private_keys/3ae88fe370c39384fc16da2c9e768cf5d2495b48.key 
   095e53c9c20e23fd01eaad953c01da9e9d3ed9bebcfed8e5b2c2fce94037d963
   cat 1.SingleNode/private_keys/bd2d69e3e68e1ab3944a865b3e566ca5c48740da.key 
   b35b8064c5c373629a05cc3ef39789ba4dacd404e6e864214ade934c198b636f
   # 分别在两个节点node1和node2上导入到节点的钱包中
   > personal.importRawKey('095e53c9c20e23fd01eaad953c01da9e9d3ed9bebcfed8e5b2c2fce94037d963', '123456')
   "0x3ae88fe370c39384fc16da2c9e768cf5d2495b48"
   > personal.importRawKey('b35b8064c5c373629a05cc3ef39789ba4dacd404e6e864214ade934c198b636f' ,'123456')
   "0xbd2d69e3e68e1ab3944a865b3e566ca5c48740da"
   # 查看一下账户中的钱，已经初始化到账啦，擦亮眼睛，这些都是真的~~~
   web3.fromWei(eth.getBalance("0x3ae88fe370c39384fc16da2c9e768cf5d2495b48"), "ether")
   web3.fromWei(eth.getBalance("0xbd2d69e3e68e1ab3944a865b3e566ca5c48740da"), "ether")
   # 转账
   var tx = {from: "0x3ae88fe370c39384fc16da2c9e768cf5d2495b48", to: "0xbd2d69e3e68e1ab3944a865b3e566ca5c48740da", value: web3.toWei(500000000000, "ether")}
   personal.sendTransaction(tx, "123456")
   # 启动挖矿，CPU开启疯狂状态
   ```

   问题： 一台节点挖矿，很容易成功，两台就很难了，貌似两个节点都卡住了，之前测试的时候没有注意到，需要深入验证，是跟【"difficulty": "0x020000",】这个有关？

   初步验证，感觉是网络问题，在node1的VM实例上创建了node3网络节点，则node1的VM实例上有两个Ethereum网络节点node1和node3，这两个节点之间开启挖矿，没有问题，只要在另外一个实例上node2一启动miner.start(1)，所有的挖矿动作就卡住了。【后注： 经过在云上的环境进行验证，这个问题在云上环境没有问题，不知道那个环境因素影响了这个问题。】

10. ​



