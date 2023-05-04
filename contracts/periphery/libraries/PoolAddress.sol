// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.16;

/// @title Provides a function for deriving a pool address from the factory, tokens, and swap fee
library PoolAddress {
    bytes32 constant CREATE2_PREFIX = 0x2020dba91b30cc0006188af794c2fb30dd8520db7e2c088b7fc7c103c00ca494;
    /// @dev `keccak256("")`
    bytes32 constant EMPTY_STRING_KECCAK = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
    /// @notice Deterministically computes the pool address from the given data
    /// @param factory the factory address
    /// @param token0 One of the tokens constituting the token pair, regardless of order
    /// @param token1 The other token constituting the token pair, regardless of order
    /// @param swapFee Fee to be collected upon every swap in the pool, in fee units
    /// @param poolInitHash The keccak256 hash of the Pool creation code
    /// @return pool the pool address
    function computeAddress(
        address factory,
        address token0,
        address token1,
        uint24 swapFee,
        bytes32 poolInitHash
    ) internal pure returns (address pool) {
        (token0, token1) = token0 < token1 ? (token0, token1) : (token1, token0);
        bytes32 hash = keccak256(
            bytes.concat(CREATE2_PREFIX, bytes32(uint256(uint160(factory))), keccak256(abi.encode(token0, token1, swapFee)), poolInitHash, EMPTY_STRING_KECCAK)
        );

        pool = address(uint160(uint256(hash)));
    }
}
