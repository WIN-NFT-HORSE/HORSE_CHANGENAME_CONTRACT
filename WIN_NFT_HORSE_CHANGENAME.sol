pragma solidity ^0.5.0;

import "./SafeMath.sol";
import "./Ownable.sol";
import "./IHorse.sol";


contract WIN_NFT_HORSE_CHANGENAME is Context, Ownable {


    uint256 private price;
    uint256 private index;
    address public CORE_ADDRESS;


    struct changes {
        uint256 token_id;
        string nickname;
    }

    mapping(uint256 => changes) public holder;
    mapping(uint256 => string) public names;

    using SafeMath for uint256;

    event ChangeName(address indexed from, uint256 indexed index, uint256 indexed token_id, string nickname);

    constructor() public {
        price = 0;
    }


    function getPrice() public view returns (uint256) {
        return price;
    }

    function setPrice(uint256 x) onlyOwner public {
        price = x;
    }

    function SET_CORE_ADDRESS(address core) public onlyOwner returns (address){
        CORE_ADDRESS = core;
        return CORE_ADDRESS;
    }

    function change_name(uint32 token_id, string memory nickname) payable public returns (uint256)  {

        require(getPrice() == msg.value, "Trx value sent is not correct");

        IAxie core = IAxie(CORE_ADDRESS);
        require(core.ownerOf(token_id) == msg.sender, "not belongs your address");


        (bool success,) = address(uint160(owner())).call.value(msg.value)("");
        require(success, "Address: unable to send value, recipient may have reverted");

        index++;
        holder[index] = changes({
        token_id : token_id,
        nickname : nickname
        });
        names[token_id] = nickname;
        emit ChangeName(msg.sender, index, token_id, nickname);

        return index;

    }
}
