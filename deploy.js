const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const {interface, bytecode} = require('./compile');

const provider = new HDWalletProvider(
  'pink omit play enact curve switch pool sure tool spin curve antique',
  'https://rinkeby.infura.io/v3/5e4cf62b40934240ad80cbbe7aef8b7e'
);

const web3 = new Web3(provider);

const deploy = async () => {
  const accounts = await web3.eth.getAccounts();
  console.log('Attempting to deploy from account', accounts[0]);


  const result = await new web3.eth.Contract(JSON.parse(interface))
    .deploy({data: '0x0' + bytecode, arguments:['This is deployed!']})
    .send({gas:'100000', from: accounts[0]});

  console.log('Contract deployed to ', result.options.address);
};
deploy();