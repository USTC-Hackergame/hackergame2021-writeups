pragma solidity =0.8.9;

contract Dummy {
    function hello() public pure returns (string memory) {
        return "Hello!";
    }
}

contract Attack {
    function predict(address challenge) public returns (address) {
        bytes1 a = 0xff;
        address b = challenge;
        bytes32 seed = Challenge(challenge).seed();
        bytes memory code = type(Dummy).creationCode;
        bytes32 hash = keccak256(
            abi.encodePacked(a, b, seed, keccak256(code))
        );
        return address(uint160(uint256(hash)));
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
    
    function predict_self() public returns (address) {
        bytes1 a = 0xff;
        address b = address(this);
        bytes memory code = type(Dummy).creationCode;
        bytes32 hash = keccak256(
            abi.encodePacked(a, b, seed, keccak256(code))
        );
        return address(uint160(uint256(hash)));
    }
    
    function predict_attack() public returns (address) {
        return address(new Attack.predict(address(this)));
    }
}