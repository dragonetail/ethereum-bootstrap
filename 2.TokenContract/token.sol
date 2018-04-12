pragma solidity ^0.4.21;

contract Token {
    address issuer;
    mapping (address => uint) balances;

    event Issue(address account, uint amount);
    event Transfer(address from, address to, uint amount);

    function Token() public {
        issuer = msg.sender;
    }

    function issue(address account, uint amount) public {
        require(msg.sender == issuer);
        balances[account] += amount;

        emit Issue(account, amount);
    }

    function transfer(address to, uint amount) public {
        require(balances[msg.sender] >= amount);

        balances[msg.sender] -= amount;
        balances[to] += amount;

        emit Transfer(msg.sender, to, amount);
    }

    function getBalance(address account) public constant returns (uint) {
        return balances[account];
    }
}

