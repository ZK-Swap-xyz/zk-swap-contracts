import {ERC20} from '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract Token is ERC20 {
    constructor(
        string memory symbol,
        string memory name
    ) ERC20(name, symbol) {
        _mint(msg.sender, 10000000000000000000000000000);
    }
}
