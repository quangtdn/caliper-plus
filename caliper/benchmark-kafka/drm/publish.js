/**
* Copyright 2017 HUAWEI. All Rights Reserved.
*
* SPDX-License-Identifier: Apache-2.0
*
*/


'use strict';

const crypto = require('crypto');

module.exports.info  = 'publishing digital items';

let bc, contx;
let itemBytes = 1024;   // default value
let ids = [];           // save the generated item ids

module.exports.ids = ids;

module.exports.init = function(blockchain, context, args) {
    if(args.hasOwnProperty('itemBytes') ) {
        itemBytes = args.itemBytes;
    }

    bc       = blockchain;
    contx    = context;

    return Promise.resolve();
};

module.exports.run = function() {
    const date   = new Date();
    const today  = (date.getMonth() + 1) + '/' + date.getDate() + '/' + date.getFullYear();
    const author = process.pid.toString();
    const buf    = crypto.randomBytes(itemBytes).toString('base64');
    const item = {
        'author' : author,
        'createtime' : today,
        'info' : '',
        'item' : buf
    };

    let args;
    if (bc.bcType === 'fabric-ccp') {
        args = {
            chaincodeFunction: 'publish',
            chaincodeArguments: [JSON.stringify(item)]
        };
    } else {
        args = {
            verb : 'publish',
            item: JSON.stringify(item)
        };
    }

    return bc.invokeSmartContract(contx, 'drm', 'v0', args, 120)
        .then(results => {
            for (let result of results){
                if(result.IsCommitted()) {
                    ids.push(result.GetResult().toString());
                }
            }
            return Promise.resolve(results);
        });
};

module.exports.end = function() {
    return Promise.resolve();
};
/**********************
* save published items' identity
**********************/
/*var idfile = './tmp/ids.log'
var fs = require('fs');
module.exports.end = function() {
     for (let i in results){
        let stat = results[i];
        if(stat.status === 'success') {
            fs.appendFileSync(idfile, stat.result.toString() + '\n');
        }
    }
    return Promise.resolve();
}*/
