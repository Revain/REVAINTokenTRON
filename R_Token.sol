pragma solidity ^0.5.8;

import "./TRC20Interface.sol";

contract R_Token is TRC20Interface {

    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowed;

    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 private _totalSupply;
    address public owner;

    constructor(
        uint256 _initialAmount,
        uint8 _decimalUnits,
        string memory _assetName,
        string memory _assetSymbol,
        address _owner
        ) public {
        balances[_owner] = _initialAmount;
        owner = _owner;
        _totalSupply = _initialAmount;
        name = _assetName;
        decimals = _decimalUnits;
        symbol = _assetSymbol;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
    function balanceOf(address assetOwner) public view returns (uint256 balance) {
        return balances[assetOwner];
    }

    function allowance(address  assetOwner, address spender) public view returns (uint256 remaining) {
        return allowed[assetOwner][spender];
    }

    function transfer(address to, uint assets) public returns (bool success) {
        if (balances[msg.sender] >= assets) {
            balances[msg.sender] -= assets;
            balances[to] += assets;
            emit Transfer(msg.sender, to, assets);
            return true;
        } else {
            return false;
        }
    }

    function approve(address spender, uint256 assets) public returns (bool success) {
        allowed[msg.sender][spender] = assets;
        emit Approval(msg.sender, spender, assets);
        return true;
    }
    function transferFrom(address from, address to, uint assets) public returns (bool success) {
        if (balances[from] >= assets && allowed[from][msg.sender] >= assets) {
            balances[to] += assets;
            balances[from] -= assets;
            allowed[from][msg.sender] -= assets;
            emit Transfer(from, to, assets);
            return true;
        } else {
            return false;
        }
    }
}