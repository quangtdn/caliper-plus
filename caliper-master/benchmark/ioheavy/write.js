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

module.exports.info  = 'Creating ioheavy: write operation.';

let txIndex = 0;
let startKey;
let totalKey;
let bc, contx;
module.exports.init = function(blockchain, context, args) {
    if(!args.hasOwnProperty('start_key')) {
        args.start_key = 0;
    }
    if(!args.hasOwnProperty('total_key_num')) {
        args.total_key_num = 1;
    }
    startKey = args.start_key;
    totalKey = args.total_key_num;
    bc = blockchain;
    contx = context;
    return Promise.resolve();
};

module.exports.run = function() {
    txIndex++;
    return bc.invokeSmartContract(contx, 'ioheavy', 'v1',
        {
            verb: 'write',
            start: startKey,
            total: totalKey
        }, 210 * totalKey);
};

module.exports.end = function() {
    return Promise.resolve();
};
