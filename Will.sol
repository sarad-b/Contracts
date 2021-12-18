pragma solidity >=0.7.0 <0.9.0;

contract Will{
    address owner;
    uint fortune;
    bool deceased;
    address payable[] familyWallet;

    constructor() payable{
        owner = msg.sender;
        fortune = msg.value;
        deceased = false;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    modifier isDeceased{
        require(deceased == true);
        _;
    }

    mapping (address => uint) inheritance;

    function setInheritance(address payable wallet, uint amount) onlyOwner public{
        familyWallet.push(wallet);
        inheritance[wallet] = amount;
    }

    function payout() isDeceased onlyOwner private{
        for(uint i = 0; i < familyWallet.length; i++){
            familyWallet[i].transfer(inheritance[familyWallet[i]]);
        }
    }

    function ownerDiceased() public onlyOwner {
        deceased = true;
        payout();
    }




}