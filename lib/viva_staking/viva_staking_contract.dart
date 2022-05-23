import 'package:vite/contract.dart';

final vivaStakingContract = Contract(
  contractAddress: 'vite_65ea4fbb8fc4a0f5cac745e0a97844ff2e9e4287aa0c35a28f',
  offchainCode:
      '608060405260043610610071576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063499c7e31146100735780634b2e2437146101655780635c6cfcbe14610217578063aa522e2114610263578063b2429568146102ce57610071565b005b61007b6102ec565b60405180806020018060200180602001848103845287818151815260200191508051906020019060200280838360005b838110156100c75780820151818401525b6020810190506100ab565b50505050905001848103835286818151815260200191508051906020019060200280838360005b8381101561010a5780820151818401525b6020810190506100ee565b50505050905001848103825285818151815260200191508051906020019060200280838360005b8381101561014d5780820151818401525b602081019050610131565b50505050905001965050505050505060405180910390f35b6101926004803603602081101561017c5760006000fd5b810190808035906020019092919050505061061a565b604051808b69ffffffffffffffffffff1669ffffffffffffffffffff1681526020018a69ffffffffffffffffffff1669ffffffffffffffffffff1681526020018981526020018881526020018781526020018681526020018581526020018481526020018381526020018281526020019a505050505050505050505060405180910390f35b61021f6106e9565b604051808274ffffffffffffffffffffffffffffffffffffffffff1674ffffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b6102b16004803603604081101561027a5760006000fd5b8101908080359060200190929190803574ffffffffffffffffffffffffffffffffffffffffff169060200190929190505050610719565b604051808381526020018281526020019250505060405180910390f35b6102d66107fd565b6040518082815260200191505060405180910390f35b60606060606060606001600050546040519080825280602002602001820160405280156103285781602001602082028038833980820191505090505b50905060606001600050546040519080825280602002602001820160405280156103615781602001602082028038833980820191505090505b509050606060086001600050540260405190808252806020026020018201604052801561039d5781602001602082028038833980820191505090505b5090506000600090505b6001600050548110156106005760006002600050600083815260200190815260200160002160005090508060010160009054906101000a900469ffffffffffffffffffff1685838151811015156103fa57fe5b9060200190602002019069ffffffffffffffffffff16908169ffffffffffffffffffff168152602001505080600101600a9054906101000a900469ffffffffffffffffffff16848381518110151561044e57fe5b9060200190602002019069ffffffffffffffffffff16908169ffffffffffffffffffff16815260200150508060020160005054836000600885020181518110151561049557fe5b90602001906020020190908181526020015050806003016000505483600160088502018151811015156104c457fe5b90602001906020020190908181526020015050806005016000505483600260088502018151811015156104f357fe5b906020019060200201909081815260200150508060060160005054836003600885020181518110151561052257fe5b906020019060200201909081815260200150508060070160005054836004600885020181518110151561055157fe5b906020019060200201909081815260200150508060080160005054836005600885020181518110151561058057fe5b90602001906020020190908181526020015050806009016000505483600660088502018151811015156105af57fe5b9060200190602002019090818152602001505080600a016000505483600760088502018151811015156105de57fe5b90602001906020020190908181526020015050505b80806001019150506103a7565b50828282955095509550505050610615565050505b909192565b60006000600060006000600060006000600060006000600260005060008d815260200190815260200160002160005090508060010160009054906101000a900469ffffffffffffffffffff1681600101600a9054906101000a900469ffffffffffffffffffff16826002016000505483600301600050548460050160005054856006016000505486600701600050548760080160005054886009016000505489600a01600050549a509a509a509a509a509a509a509a509a509a50506106dc56505b9193959799509193959799565b6000600060009054906101000a900474ffffffffffffffffffffffffffffffffffffffffff169050610716565b90565b600060006002600050600085815260200190815260200160002160005060000160005060008474ffffffffffffffffffffffffffffffffffffffffff1674ffffffffffffffffffffffffffffffffffffffffff168152602001908152602001600021600050600001600050546002600050600086815260200190815260200160002160005060000160005060008574ffffffffffffffffffffffffffffffffffffffffff1674ffffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002160005060010160005054915091506107f6565b9250929050565b6000600160005054905061080c565b9056fea165627a7a7230582025e3585d5812f884c814e446d806496e82665cbc658a6f4e39be590c2e64e2af0029',
  abi: [
    {
      "constant": false,
      "inputs": [
        {"name": "PoolId", "type": "uint256"}
      ],
      "name": "deposit",
      "outputs": [],
      "payable": true,
      "stateMutability": "payable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {"name": "PoolId", "type": "uint256"},
        {"name": "amount", "type": "uint256"}
      ],
      "name": "withdraw",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    // Offchain
    {
      "constant": true,
      "inputs": [],
      "name": "getAllPoolInfo",
      "outputs": [
        {"name": "stakingTokenIds", "type": "tokenId[]"},
        {"name": "rewardTokenIds", "type": "tokenId[]"},
        {"name": "packedIntegers", "type": "uint256[]"}
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "offchain"
    },
    {
      "constant": true,
      "inputs": [
        {"name": "PoolId", "type": "uint256"}
      ],
      "name": "getPoolInfo",
      "outputs": [
        {"name": "stakingTokenId", "type": "tokenId"},
        {"name": "rewardTokenId", "type": "tokenId"},
        {"name": "totalStakingBalance", "type": "uint256"},
        {"name": "totalRewardBalance", "type": "uint256"},
        {"name": "startBlock", "type": "uint256"},
        {"name": "endBlock", "type": "uint256"},
        {"name": "latestRewardBlock", "type": "uint256"},
        {"name": "rewardPerPeriod", "type": "uint256"},
        {"name": "rewardPerToken", "type": "uint256"},
        {"name": "paidOut", "type": "uint256"}
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "offchain"
    },
    {
      "constant": true,
      "inputs": [
        {"name": "PoolId", "type": "uint256"},
        {"name": "addr", "type": "address"}
      ],
      "name": "getUserInfo",
      "outputs": [
        {"name": "stakingBalance", "type": "uint256"},
        {"name": "rewardDebt", "type": "uint256"}
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "offchain"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "getPoolCount",
      "outputs": [
        {"name": "pool_count", "type": "uint256"}
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "offchain"
    },
    // Events
    {
      "anonymous": false,
      "inputs": [
        {"indexed": true, "name": "addr", "type": "address"},
        {"indexed": true, "name": "pid", "type": "uint256"},
        {"indexed": false, "name": "amount", "type": "uint256"}
      ],
      "name": "Deposit",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {"indexed": true, "name": "addr", "type": "address"},
        {"indexed": true, "name": "pid", "type": "uint256"},
        {"indexed": false, "name": "amount", "type": "uint256"}
      ],
      "name": "Withdraw",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {"indexed": true, "name": "addr", "type": "address"},
        {"indexed": true, "name": "pid", "type": "uint256"},
        {"indexed": false, "name": "amount", "type": "uint256"}
      ],
      "name": "Claim",
      "type": "event"
    }
  ],
);
