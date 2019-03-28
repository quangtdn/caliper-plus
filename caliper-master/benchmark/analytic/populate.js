/*
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

'use strict';

module.exports.info  = 'Creating analytic: write operation.';

const batch_size = 3;
let txIndex = 0;

let total_size;
let bc, contx;

function gen_acc(n) {
  var zeros = "00000000000000000000"
  var str = n.toString();
  return "0x"+zeros.slice(str.length)+str;
}

function generateTransactions() {
  let transaction = [];
  var txn_count = 0;
  while (txn_count < total_size) {
    for (var i = 0; i < batch_size; ++i) {
      var from = Math.round(zipfGenerator.next());
      var to = Math.round(zipfGenerator.next());
      while(from == to || from > 99999 || to > 99999 || from < 0 || to < 0) {
        from = Math.round(zipfGenerator.next());
        to = Math.round(zipfGenerator.next());
      }
      // console.log(from, " - ",  to);
      var val = Math.floor((Math.random() * 100) + 1);
      //invoke("Send", [gen_acc(from), gen_acc(to), val.toString()]);
      let txn = {
    		'From': gen_acc(from),
    		'To':   gen_acc(to),
    		'Val':  val.toString(),
        'transaction_type': 'Send'
    	};
      transaction.push(txn);
    }
    //invoke("Commit", []);
    let txn = {
      'Arg': [],
      'transaction_type': 'Commit'
    };
    transaction.push(txn);
    txn_count += batch_size;
  }
  return transaction;
}

module.exports.init = function(blockchain, context, args) {
    if(!args.hasOwnProperty('block_number')) {
        args.block_number = 100;
    }

    total_size = args.block_number;
    bc = blockchain;
    contx = context;
    return Promise.resolve();
};

module.exports.run = function() {
  let args = generateTransactions();
  return bc.invokeSmartContract(contx, 'analytic', '1.0', args, 500);
};

module.exports.end = function() {
    return Promise.resolve();
};
