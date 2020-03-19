const path = require('path');  
const fs = require('fs');

const solc = require('solc');

const myContractPath = path.resolve(__dirname,'contracts','Inbox.sol');

const source = fs.readFileSync(myContractPath,'utf8');

module.exports = solc.compile(source,1).contracts[':Inbox'];