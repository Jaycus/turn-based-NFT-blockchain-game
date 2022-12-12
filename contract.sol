pragma solidity ^0.8.0;

// Define a contract for a non-fungible token (NFT) in the game
contract NFT {
    // The name of the NFT
    string public name;
    // The attack power of the NFT
    uint256 public attackPower;
    // The defense power of the NFT
    uint256 public defensePower;

    // Constructor function to create a new NFT
    constructor(string memory _name, uint256 _attackPower, uint256 _defensePower) public {
        name = _name;
        attackPower = _attackPower;
        defensePower = _defensePower;
    }
}

// Define a contract for a game of NFT Showdown
contract NFTShowdown {
    // The address of the player who created the game
    address public creator;
    // The address of the player who is currently playing the game
    address public currentPlayer;
    // The non-fungible tokens (NFTs) used by the creator in the game
    NFT[] public creatorNFTs;
    // The non-fungible tokens (NFTs) used by the opponent in the game
    NFT[] public opponentNFTs;

    // Constructor function to create a new game of NFT Showdown
    constructor(address _creator, NFT[] memory _creatorNFTs) public {
        creator = _creator;
        currentPlayer = _creator;
        creatorNFTs = _creatorNFTs;
    }
    
    // Function to allow the opponent to join the game
    function joinGame(address _opponent, NFT[] memory _opponentNFTs) public {
        require(currentPlayer != _opponent);
        opponentNFTs = _opponentNFTs;
        currentPlayer = _opponent;
    }

    // Function to calculate the total attack power of all NFTs
    function calculateTotalAttackPower() public view returns (uint256) {
        uint256 totalAttackPower = 0;
        // Calculate the total attack power of the creator's NFTs
        for (uint256 i = 0; i < creatorNFTs.length; i++) {
            totalAttackPower += creatorNFTs[i].attackPower;
        }
        // Calculate the total attack power of the opponent's NFTs
        for (uint256 i = 0; i < opponentNFTs.length; i++) {
            totalAttackPower += opponentNFTs[i].attackPower;
        }
        return totalAttackPower;
    }

    // Function to calculate the total defense power of all NFTs
    function calculateTotalDefensePower() public view returns (uint256) {
        uint256 totalDefensePower = 0;
        // Calculate the total defense power of the creator's NFTs
        for (uint256 i = 0; i < creatorNFTs.length; i++) {
            totalDefensePower += creatorNFTs[i].defensePower;
        }
        // Calculate the total defense power of the opponent's NFTs
        for (uint256 i = 0; i < opponentNFTs.length; i++) {
            totalDefensePower += opponentNFTs[i].defensePower;
        }
        return totalDefensePower;
    }

    // Function to calculate the winner of the game
    function calculateWinner() public view returns (address) {
        uint256 totalAttackPower = calculateTotalAttackPower();
        uint256 totalDefensePower = calculateTotalDefensePower();
        // If the total attack power is greater than the total defense power, the creator is the winner
        if (totalAttackPower > totalDefensePower) {
            return creator;
        }
        // If the total attack power is less than or equal to the total defense power, the opponent is the winner
        else {
            return currentPlayer;
        }
    }

}
