#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.
set -ev

# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1


# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=10
#echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}

#start ca1

docker run --rm -it --network="my-net" --name ca.org1.example.com -p 7054:7054 -e FABRIC_CA_HOME=/etc/hyperledger/fabric-ca-server -e FABRIC_CA_SERVER_CA_NAME=ca.org1.example.com -v $(pwd)/../config/crypto-config/peerOrganizations/org1.example.com/ca/:/etc/hyperledger/fabric-ca-server-config -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=my-net hyperledger/fabric-ca:1.1.0  sh -c 'fabric-ca-server start --ca.certfile /etc/hyperledger/fabric-ca-server-config/ca.org1.example.com-cert.pem --ca.keyfile /etc/hyperledger/fabric-ca-server-config/key.pem -b admin:adminpw -d'

#start ca2

docker run --rm -it --network="my-net" --name ca.org2.example.com -p 8054:7054 -e FABRIC_CA_HOME=/etc/hyperledger/fabric-ca-server -e FABRIC_CA_SERVER_CA_NAME=ca.org2.example.com -v $(pwd)/../config/crypto-config/peerOrganizations/org1.example.com/ca/:/etc/hyperledger/fabric-ca-server-config -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=my-net hyperledger/fabric-ca:1.1.0  sh -c 'fabric-ca-server start --ca.certfile /etc/hyperledger/fabric-ca-server-config/ca.org1.example.com-cert.pem --ca.keyfile /etc/hyperledger/fabric-ca-server-config/key.pem -b admin:adminpw -d'

#start orderer

docker run --rm -it --network="my-net" --name orderer.example.com -p 7050:7050 -e ORDERER_GENERAL_LOGLEVEL=debug -e ORDERER_GENERAL_LISTENADDRESS=0.0.0.0  -e ORDERER_GENERAL_GENESISMETHOD=file -e ORDERER_GENERAL_GENESISFILE=/etc/hyperledger/configtx/orgs.genesis.block -e ORDERER_GENERAL_LOCALMSPID=OrdererMSP -e ORDERER_GENERAL_LOCALMSPDIR=/etc/hyperledger/msp/orderer/msp -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=my-net -w /opt/gopath/src/github.com/hyperledger/fabric -v $(pwd)/../config/:/etc/hyperledger/configtx -v $(pwd)/../config/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp:/etc/hyperledger/msp/orderer/msp hyperledger/fabric-orderer:1.1.0 orderer 

#start peer0.org1.example.com

docker run --rm -it --link orderer.example.com:orderer.example.com --network="my-net" --name peer0.org1.example.com -p 7051:7051 -p 7053:7053 -e CORE_LOGGING_PEER=debug -e CORE_CHAINCODE_LOGGING_LEVEL=DEBUG -e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock -e CORE_PEER_ID=peer0.org1.example.com -e CORE_PEER_ENDORSER_ENABLED=true -e CORE_PEER_ADDRESS=peer0.org1.example.com:7051 -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=my-net -e CORE_PEER_LOCALMSPID=Org1MSP -e CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/peer/msp -e CORE_PEER_GOSSIP_USELEADERELECTION=true -e CORE_PEER_GOSSIP_ORGLEADER=false -e CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer0.org1.example.com:7051  -w /opt/gopath/src/github.com/hyperledger/fabric  -v /var/run/:/host/var/run/ -v $(pwd)/../config/mychannel.tx:/etc/hyperledger/configtx/mychannel.tx -v $(pwd)/../config/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp:/etc/hyperledger/peer/msp -v $(pwd)/../config/crypto-config/peerOrganizations/org1.example.com/users:/etc/hyperledger/msp/users  hyperledger/fabric-peer:1.1.0 peer node start


#start peer0.org2.example.com

docker run --rm -it --link orderer.example.com:orderer.example.com --link peer0.org1.example.com:peer0.org1.example.com --network="my-net" --name peer0.org2.example.com -p 8051:7051 -p 8053:7053 -e CORE_LOGGING_PEER=debug -e CORE_CHAINCODE_LOGGING_LEVEL=DEBUG -e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock -e CORE_PEER_ID=peer0.org2.example.com -e CORE_PEER_ENDORSER_ENABLED=true -e CORE_PEER_ADDRESS=peer0.org2.example.com:7051 -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=my-net -e CORE_PEER_LOCALMSPID=Org2MSP -e CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/peer/msp -e CORE_PEER_GOSSIP_USELEADERELECTION=true -e CORE_PEER_GOSSIP_ORGLEADER=false -e CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer0.org2.example.com:7051  -w /opt/gopath/src/github.com/hyperledger/fabric  -v /var/run/:/host/var/run/ -v $(pwd)/../config/mychannel.tx:/etc/hyperledger/configtx/mychannel.tx -v $(pwd)/../config/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp:/etc/hyperledger/peer/msp -v $(pwd)/../config/crypto-config/peerOrganizations/org2.example.com/users:/etc/hyperledger/msp/users  hyperledger/fabric-peer:1.1.0 peer node start

























