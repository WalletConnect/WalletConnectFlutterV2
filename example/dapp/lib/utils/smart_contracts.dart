class SepoliaTestContract {
  // Alfreedoms2 ALF2 in Sepolia
  // DEPLOY https://sepolia.etherscan.io/tx/0xebf287281abbc976b7cf6956a7f5f66338935d324c6453a350e3bb42ff7bd4e2
  // MINT https://sepolia.etherscan.io/tx/0x04a015504be7420a40a59936bfcca9302e55700fd00129059444539770fed5e7
  // CONTRACT https://sepolia.etherscan.io/address/0xBe60D05C11BD1C365849C824E0C2D880d2466eAF
  // TRANSFERS https://sepolia.etherscan.io/token/0xbe60d05c11bd1c365849c824e0c2d880d2466eaf?a=0x59e2f66C0E96803206B6486cDb39029abAE834c0
  // SOURCIFY https://repo.sourcify.dev/contracts/full_match/11155111/0xBe60D05C11BD1C365849C824E0C2D880d2466eAF/
  static const contractAddress = '0xBe60D05C11BD1C365849C824E0C2D880d2466eAF';

  static const readContractAbi = [
    {
      "inputs": [
        {"internalType": "address", "name": "initialOwner", "type": "address"}
      ],
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "spender", "type": "address"},
        {"internalType": "uint256", "name": "allowance", "type": "uint256"},
        {"internalType": "uint256", "name": "needed", "type": "uint256"}
      ],
      "name": "ERC20InsufficientAllowance",
      "type": "error"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "sender", "type": "address"},
        {"internalType": "uint256", "name": "balance", "type": "uint256"},
        {"internalType": "uint256", "name": "needed", "type": "uint256"}
      ],
      "name": "ERC20InsufficientBalance",
      "type": "error"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "approver", "type": "address"}
      ],
      "name": "ERC20InvalidApprover",
      "type": "error"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "receiver", "type": "address"}
      ],
      "name": "ERC20InvalidReceiver",
      "type": "error"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "sender", "type": "address"}
      ],
      "name": "ERC20InvalidSender",
      "type": "error"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "spender", "type": "address"}
      ],
      "name": "ERC20InvalidSpender",
      "type": "error"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "owner", "type": "address"}
      ],
      "name": "OwnableInvalidOwner",
      "type": "error"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "account", "type": "address"}
      ],
      "name": "OwnableUnauthorizedAccount",
      "type": "error"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "owner",
          "type": "address"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "spender",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "value",
          "type": "uint256"
        }
      ],
      "name": "Approval",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "previousOwner",
          "type": "address"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "newOwner",
          "type": "address"
        }
      ],
      "name": "OwnershipTransferred",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "from",
          "type": "address"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "to",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "value",
          "type": "uint256"
        }
      ],
      "name": "Transfer",
      "type": "event"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "owner", "type": "address"},
        {"internalType": "address", "name": "spender", "type": "address"}
      ],
      "name": "allowance",
      "outputs": [
        {"internalType": "uint256", "name": "", "type": "uint256"}
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "spender", "type": "address"},
        {"internalType": "uint256", "name": "value", "type": "uint256"}
      ],
      "name": "approve",
      "outputs": [
        {"internalType": "bool", "name": "", "type": "bool"}
      ],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "account", "type": "address"}
      ],
      "name": "balanceOf",
      "outputs": [
        {"internalType": "uint256", "name": "", "type": "uint256"}
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "decimals",
      "outputs": [
        {"internalType": "uint8", "name": "", "type": "uint8"}
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "to", "type": "address"},
        {"internalType": "uint256", "name": "amount", "type": "uint256"}
      ],
      "name": "mint",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "name",
      "outputs": [
        {"internalType": "string", "name": "", "type": "string"}
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "owner",
      "outputs": [
        {"internalType": "address", "name": "", "type": "address"}
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "renounceOwnership",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "symbol",
      "outputs": [
        {"internalType": "string", "name": "", "type": "string"}
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "totalSupply",
      "outputs": [
        {"internalType": "uint256", "name": "", "type": "uint256"}
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "to", "type": "address"},
        {"internalType": "uint256", "name": "value", "type": "uint256"}
      ],
      "name": "transfer",
      "outputs": [
        {"internalType": "bool", "name": "", "type": "bool"}
      ],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "from", "type": "address"},
        {"internalType": "address", "name": "to", "type": "address"},
        {"internalType": "uint256", "name": "value", "type": "uint256"}
      ],
      "name": "transferFrom",
      "outputs": [
        {"internalType": "bool", "name": "", "type": "bool"}
      ],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "newOwner", "type": "address"}
      ],
      "name": "transferOwnership",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    }
  ];
}
