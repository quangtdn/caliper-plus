#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: $0 <# of nodes>"
	exit 1
fi
N=$1

set -x

STARTNODE=20
NETWORKNAME="my-net"
WORKINGDIR="$HOME/caliper/network/fabric-v1.1/2org1peergoleveldb"
PEERLINK=""

declare -a CASERVER
declare -a PEERREQ
declare -a PEEREVENT
CASERVER=(0 7054 8054 6054)
PEERREQ=(0 7051 8051)
PEEREVENT=(0 7053 8053)

for IDX in `seq 1 $N`; do
	PEERLINK="$PEERLINK --link peer0.org$IDX.example.com:peer0.org$IDX.example.com "
done



for IDX in `seq 1 $N`; do
	NODEIDX=$(($STARTNODE+$IDX-1))
	NODE="slave-$NODEIDX"
	ssh $NODE "docker swarm leave --force"
done

ssh slave-$STARTNODE "docker swarm init"
CMD=`ssh slave-$STARTNODE "docker swarm join-token manager | tail -n2 | head -n1"`

echo "Swarm Join Command: $CMD"

for IDX in `seq 2 $N`; do
	NODEIDX=$(($STARTNODE+$IDX-1))
        NODE="slave-$NODEIDX"
	ssh $NODE "$CMD"
done

# create network
ssh slave-$STARTNODE "docker network create --subnet 10.10.0.0/16 --attachable --driver overlay $NETWORKNAME"

#start ca1
for IDX in `seq 1 $N`; do
	NODEIDX=$(($STARTNODE+$IDX-1))
        NODE="slave-$NODEIDX"
	ORGNAME="org$IDX.example.com"
	CANAME="ca.$ORGNAME"
	CA_SERVER=${CASERVER[$IDX]}
	ssh $NODE "cd $WORKINGDIR &&  docker run --rm -it -d --network=$NETWORKNAME --name $CANAME -p $CA_SERVER:7054 -e FABRIC_CA_HOME=/etc/hyperledger/fabric-ca-server -e FABRIC_CA_SERVER_CA_NAME=$CANAME -v $WORKINGDIR/../config/crypto-config/peerOrganizations/$ORGNAME/ca/:/etc/hyperledger/fabric-ca-server-config -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=$NETWORKNAME hyperledger/fabric-ca:1.1.0  sh -c 'fabric-ca-server start --ca.certfile /etc/hyperledger/fabric-ca-server-config/"$CANAME"-cert.pem --ca.keyfile /etc/hyperledger/fabric-ca-server-config/key.pem -b admin:adminpw -d'"
done

#start orderer
ssh slave-$STARTNODE "cd $WORKINGDIR && docker run --rm -it -d --network=$NETWORKNAME --name orderer.example.com -p 7050:7050 -e ORDERER_GENERAL_LOGLEVEL=debug -e ORDERER_GENERAL_LISTENADDRESS=0.0.0.0  -e ORDERER_GENERAL_GENESISMETHOD=file -e ORDERER_GENERAL_GENESISFILE=/etc/hyperledger/configtx/orgs.genesis.block -e ORDERER_GENERAL_LOCALMSPID=OrdererMSP -e ORDERER_GENERAL_LOCALMSPDIR=/etc/hyperledger/msp/orderer/msp -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=$NETWORKNAME -w /opt/gopath/src/github.com/hyperledger/fabric -v $WORKINGDIR/../config/:/etc/hyperledger/configtx -v $WORKINGDIR/../config/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp:/etc/hyperledger/msp/orderer/msp hyperledger/fabric-orderer:1.1.0 orderer "

#start peer0.org1.example.com
for IDX in `seq 1 $N`; do
	NODEIDX=$(($STARTNODE+$IDX-1))
        NODE="slave-$NODEIDX"
	PEERNAME="peer0.org$IDX.example.com"
	PEER_REQ=${PEERREQ[$IDX]}
	PEER_EVENT=${PEEREVENT[$IDX]}
	ssh $NODE "cd $WORKINGDIR && docker run --rm -it -d --link orderer.example.com:orderer.example.com $PEERLINK  --network=$NETWORKNAME --name $PEERNAME -p $PEER_REQ:7051 -p $PEER_EVENT:7053 -e CORE_LOGGING_PEER=debug -e CORE_CHAINCODE_LOGGING_LEVEL=DEBUG -e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock -e CORE_PEER_ID=$PEERNAME -e CORE_PEER_ENDORSER_ENABLED=true -e CORE_PEER_ADDRESS=$PEERNAME:7051 -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=$NETWORKNAME -e CORE_PEER_LOCALMSPID=Org"$IDX"MSP -e CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/peer/msp -e CORE_PEER_GOSSIP_USELEADERELECTION=true -e CORE_PEER_GOSSIP_ORGLEADER=false -e CORE_PEER_GOSSIP_EXTERNALENDPOINT=$PEERNAME:7051  -w /opt/gopath/src/github.com/hyperledger/fabric  -v /var/run/:/host/var/run/ -v $WORKINGDIR/../config/mychannel.tx:/etc/hyperledger/configtx/mychannel.tx -v $WORKINGDIR/../config/crypto-config/peerOrganizations/org$IDX.example.com/peers/$PEERNAME/msp:/etc/hyperledger/peer/msp -v $WORKINGDIR/../config/crypto-config/peerOrganizations/org$IDX.example.com/users:/etc/hyperledger/msp/users  hyperledger/fabric-peer:1.1.0 peer node start"
done


#start peer0.org2.example.com

#docker run --rm -it --link orderer.example.com:orderer.example.com --link peer0.org1.example.com:peer0.org1.example.com --network="my-net" --name peer0.org2.example.com -p 8051:7051 -p 8053:7053 -e CORE_LOGGING_PEER=debug -e CORE_CHAINCODE_LOGGING_LEVEL=DEBUG -e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock -e CORE_PEER_ID=peer0.org2.example.com -e CORE_PEER_ENDORSER_ENABLED=true -e CORE_PEER_ADDRESS=peer0.org2.example.com:7051 -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=my-net -e CORE_PEER_LOCALMSPID=Org2MSP -e CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/peer/msp -e CORE_PEER_GOSSIP_USELEADERELECTION=true -e CORE_PEER_GOSSIP_ORGLEADER=false -e CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer0.org2.example.com:7051  -w /opt/gopath/src/github.com/hyperledger/fabric  -v /var/run/:/host/var/run/ -v $(pwd)/../config/mychannel.tx:/etc/hyperledger/configtx/mychannel.tx -v $(pwd)/../config/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp:/etc/hyperledger/peer/msp -v $(pwd)/../config/crypto-config/peerOrganizations/org2.example.com/users:/etc/hyperledger/msp/users  hyperledger/fabric-peer:1.1.0 peer node start



