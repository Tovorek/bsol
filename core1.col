// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract BandwidthMarket {
    address public owner;
    
    struct BandwidthContract {
        address 0x4bA2aab31219aA7d2A3969664B1981B40D13d340;
        uint256 bandwidthQuantity;
        uint256 price;
        uint256 duration; // in seconds
        bool isActive;
    }
    
    mapping(uint256 => BandwidthContract) public contracts; // ContractID to BandwidthContract
    uint256 public nextContractId = 0;

    event ContractCreated(uint256 contractId, address seller, uint256 bandwidthQuantity, uint256 price, uint256 duration);
    event ContractFulfilled(uint256 contractId, address buyer);
    event ContractCanceled(uint256 contractId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createBandwidthContract(uint256 bandwidthQuantity, uint256 price, uint256 duration) external returns (uint256) {
        BandwidthContract memory newContract = BandwidthContract({
            seller: msg.sender,
            bandwidthQuantity: bandwidthQuantity,
            price: price,
            duration: duration,
            isActive: true
        });
        
        contracts[nextContractId] = newContract;
        
        emit ContractCreated(nextContractId, msg.sender, bandwidthQuantity, price, duration);

        return nextContractId++;
    }

    function fulfillContract(uint256 contractId) external payable {
        BandwidthContract memory bandwidthContract = contracts[contractId];

        require(bandwidthContract.isActive, "Contract is not active");
        require(msg.value == bandwidthContract.price, "Incorrect payment amount");
        
        // Transfer the payment to the seller
        payable(bandwidthContract.seller).transfer(msg.value);
        
        // Mark the contract as fulfilled
        contracts[contractId].isActive = false;
        
        emit ContractFulfilled(contractId, msg.sender);
    }

    function cancelContract(uint256 contractId) external {
        require(contracts[contractId].seller == msg.sender, "Not the contract seller");

        contracts[contractId].isActive = false;
        
        emit ContractCanceled(contractId);
    }

    // Function to update contract attributes, using ownership check function
    function setContractAttribute(uint256 contractId, uint256 newBandwidthQuantity, uint256 newPrice, uint256 newDuration) external onlyOwner {
        contracts[contractId].bandwidthQuantity = newBandwidthQuantity;
        contracts[contractId].price = newPrice;
        contracts[contractId].duration = newDuration;
    }
}

