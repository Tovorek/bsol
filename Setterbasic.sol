// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract BandwidthMarket {
    address public owner;

    struct BandwidthContract {
        address seller;
        uint256 bandwidthQuantity;
        uint256 price;
        uint256 duration; // in seconds
        bool isActive;
    }

    mapping(uint256 => BandwidthContract) public contracts; // ContractID to BandwidthContract

    event ContractUpdated(uint256 contractId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Setter function for updating the seller of a contract
    function setSeller(uint256 contractId, address newSeller) external onlyOwner {
        contracts[contractId].seller = newSeller;
        emit ContractUpdated(contractId);
    }

    // Setter function for updating the bandwidth quantity of a contract
    function setBandwidthQuantity(uint256 contractId, uint256 newBandwidthQuantity) external onlyOwner {
        contracts[contractId].bandwidthQuantity = newBandwidthQuantity;
        emit ContractUpdated(contractId);
    }

    // Setter function for updating the price of a contract
    function setPrice(uint256 contractId, uint256 newPrice) external onlyOwner {
        contracts[contractId].price = newPrice;
        emit ContractUpdated(contractId);
    }

    // Setter function for updating the duration of a contract
    function setDuration(uint256 contractId, uint256 newDuration) external onlyOwner {
        contracts[contractId].duration = newDuration;
        emit ContractUpdated(contractId);
    }

    // Setter function for updating the active status of a contract
    function setIsActive(uint256 contractId, bool newStatus) external onlyOwner {
        contracts[contractId].isActive = newStatus;
        emit ContractUpdated(contractId);
    }
}
