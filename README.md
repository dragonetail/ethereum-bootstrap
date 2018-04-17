# Ethereum Bootstrap

[1.SingleNode](./1.SingleNode/)： 单节点以太坊部署

[2.TokenContract](./2.TokenContract/)：智能合约（Token代币）的部署和验证

[3.LocalNetworkCluster](./3.LocalNetworkCluster/)：本地网络集群

[4.LocalUbuntuDocker](./4.LocalUbuntuDocker/)：Mac本地Ubuntu环境配置



[常用命令整理](./CommonCommands.md)



参考URL：

- [管理API命令参考](https://github.com/ethereum/go-ethereum/wiki/Management-APIs)
- [管理账号参考](https://github.com/ethereum/go-ethereum/wiki/Managing-your-accounts)



```
$ geth attach ipc:/some/custom/path
$ geth attach http://191.168.1.1:8545
$ geth attach ws://191.168.1.1:8546
```

```
$ geth --exec "eth.blockNumber" attach
```

```
$ geth --exec 'loadScript("/tmp/checkbalances.js")' attach http://123.123.123.123:8545
$ geth --jspath "/tmp" --exec 'loadScript("checkbalances.js")' attach http://123.123.123.123:8545
```


云上测试环境：

 geth-node01 10.20.1.8

 geth-node02 10.20.1.9、172.17.20.97

 geth-node03 10.20.1.13 、172.17.20.28