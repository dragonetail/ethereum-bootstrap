pragma solidity ^0.4.21;

contract Coin {
    // 关键字“public”让这些变量可以从外部读取
    address public minter;
    mapping (address => uint) public balances;

    // 轻客户端可以通过事件针对变化作出高效的反应
    event Minting(address receiver, uint amount);
    event Mint(address receiver, uint amount);
    event Sending(address from, address to, uint amount);
    event Sent(address from, address to, uint amount);

    // 这是构造函数，只有当合约创建时运行
    constructor() public {
        minter = msg.sender;
    }

    function mint(address receiver, uint amount) public {
        emit Minting(receiver, amount);
        if (msg.sender != minter) return;
        balances[receiver] += amount;
        
        emit Mint(receiver, amount);
    }

    function send(address receiver, uint amount) public {
        emit Sending(msg.sender, receiver, amount);
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        
        emit Sent(msg.sender, receiver, amount);
    }
    
    function getBalance() public constant returns (uint _balanceForAccount) {
        _balanceForAccount = balances[msg.sender];
    }
}
