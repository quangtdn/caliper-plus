#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: $0 <# of peer nodes> <# of Kafka> <# of Orderer> <Zookeeper>"
	exit 1
fi
N=$1
K=$2
O=$3
Z=$4

set -x

cd `dirname ${BASH_SOURCE-$0}`
WORKINGDIR=`pwd`
KAFKADIR="$WORKINGDIR/hlf-deployment-kafka/deployment"

STARTNODE=20
ORDERINGNODE=30
ZOOKEEPERNODE=$(($ORDERINGNODE + $O))
KAFKANODE=$(($ZOOKEEPERNODE + $Z))
NETWORKNAME="my-net"
PEERLINK=""

# if dstat is not needed, replace the command with some other command that does not affect the system, e.g., hostname
# DSTAT_CMD="hostname"
DSTAT_CMD="dstat -t -c -C total -d --disk-tps -m -n --integer --noheader --nocolor > /data/dumi/dstat.log 2>&1"

declare -a CASERVER
declare -a PEERREQ
declare -a PEEREVENT
declare -a ORDERERPORT
CASERVER=(0 7054 8054 6054)
PEERREQ=(0 7051 8051 9051)
PEEREVENT=(0 7053 8053 9053)
ORDERERPORT=(0 8050 8050 9050)


ONE=1
COUNT=$(($O - $ONE))
for IDX in `seq 0 $COUNT`; do
	#ORDERERLINK="$ORDERERLINK --link orderer$IDX.example.com:orderer$IDX.example.com "
	echo hei $IDX
done

for IDX in `seq 1 $N`; do
	PEERLINK="$PEERLINK --link peer0.org$IDX.example.com:peer0.org$IDX.example.com "
done



for IDX in `seq 1 $N`; do
	NODEIDX=$(($STARTNODE+$IDX-1))
	NODE="slave-$NODEIDX"
	ssh $NODE "docker swarm leave --force"
done

for IDX in `seq 1 $O`; do
	NODEIDX=$(($ORDERINGNODE+$IDX-1))
        NODE="slave-$NODEIDX"
	ssh $NODE "docker swarm leave --force"
done

for IDX in `seq 1 $K`; do
	NODEIDX=$(($KAFKANODE+$IDX-1))
        NODE="slave-$NODEIDX"
	ssh $NODE "docker swarm leave --force"
done

for IDX in `seq 1 $Z`; do
	NODEIDX=$(($ZOOKEEPERNODE+$IDX-1))
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
	ssh $NODE "$DSTAT_CMD"
done

for IDX in `seq 1 $O`; do
	NODEIDX=$(($ORDERINGNODE+$IDX-1))
        NODE="slave-$NODEIDX"
	ssh $NODE "$CMD"
	ssh $NODE "$DSTAT_CMD"
done

for IDX in `seq 1 $K`; do
	NODEIDX=$(($KAFKANODE+$IDX-1))
        NODE="slave-$NODEIDX"
	ssh $NODE "$CMD"
	ssh $NODE "$DSTAT_CMD"
done

for IDX in `seq 1 $Z`; do
	NODEIDX=$(($ZOOKEEPERNODE+$IDX-1))
        NODE="slave-$NODEIDX"
	ssh $NODE "$CMD"
	ssh $NODE "$DSTAT_CMD"
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
	ssh $NODE "cd $WORKINGDIR && docker run --rm -it -d --network=$NETWORKNAME --name $CANAME -p $CA_SERVER:7054 -e FABRIC_CA_HOME=/etc/hyperledger/fabric-ca-server -e FABRIC_CA_SERVER_CA_NAME=$CANAME -v $WORKINGDIR/../crypto-config/peerOrganizations/$ORGNAME/ca/:/etc/hyperledger/fabric-ca-server-config -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=$NETWORKNAME -e FABRIC_CA_SERVER_CA_CERTFILE=/etc/hyperledger/fabric-ca-server-config/ca.org$IDX.example.com-cert.pem -e FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/key.pem hyperledger/fabric-ca:1.1.0  sh -c 'fabric-ca-server start -b admin:adminpw'"
done



#start zookeeper
ZOOSERVER=""
KAFKACONNECT=""
ZOOKEEPERLINK=""
for IDX in `seq 1 $Z`; do
	COUNT=$(($IDX - 1))
	ZOOSERVER="${ZOOSERVER}server.$IDX=zookeeper$COUNT:2888:3888 "
	KAFKACONNECT="${KAFKACONNECT}zookeeper$COUNT:2181,"
	ZOOKEEPERLINK="$ZOOKEEPERLINK --link zookeeper$COUNT:zookeeper$COUNT "
done
ZOOSERVER="${ZOOSERVER::-1}"
#ZOOSERVER="'""$ZOOSERVER""'"
KAFKACONNECT="${KAFKACONNECT::-1}"

for IDX in `seq 1 $Z`; do
	NODEIDX=$(($ZOOKEEPERNODE+$IDX-1))
  NODE="slave-$NODEIDX"
	COUNT=$(($IDX - 1))
	ZOOKEEPERNAME="zookeeper$COUNT"
	#CMD="cd $WORKINGDIR && docker run --rm -it -d --network=$NETWORKNAME --name $ZOOKEEPERNAME -p 2181 -p 2888 -p 3888 -e ZOO_MY_ID=$IDX -e ZOO_SERVERS=""'""$ZOOSERVER""'""hyperledger/fabric-zookeeper"
	#ssh $NODE "$CMD"
	ssh $NODE "cd $WORKINGDIR && docker run --rm -it -d --network=$NETWORKNAME --name $ZOOKEEPERNAME -p 2181 -p 2888 -p 3888 -e ZOO_MY_ID=$IDX -e ZOO_SERVERS='$ZOOSERVER' hyperledger/fabric-zookeeper"
	sleep 2s
done


sleep 6s

#start kafka
ORDERER_KAFKA_CONNECT="["
KAFKALINK=""
#KAFKA_BASE_ENV=" -p 9092 -e KAFKA_LOG_RETENTION_MS=-1 -e KAFKA_MESSAGE_MAX_BYTES=103809024 -e KAFKA_REPLICA_FETCH_MAX_BYTES=103809024 -e KAFKA_UNCLEAN_LEADER_ELECTION_ENABLE=false -e KAFKA_DEFAULT_REPLICATION_FACTOR=\${KAFFKA_DEFAULT_REPLICATION_FACTOR} -e KAFKA_MIN_INSYNC_REPLICAS=2 "
KAFKA_BASE_ENV=" -p 9092 -e KAFKA_ZOOKEEPER_TIMEOUT_MS=36000 -e KAFKA_LOG_RETENTION_MS=-1 -e KAFKA_MESSAGE_MAX_BYTES=103809024 -e KAFKA_REPLICA_FETCH_MAX_BYTES=103809024 -e KAFKA_UNCLEAN_LEADER_ELECTION_ENABLE=false -e KAFKA_DEFAULT_REPLICATION_FACTOR=2 -e KAFKA_MIN_INSYNC_REPLICAS=2 "
for IDX in `seq 1 $K`; do
	NODEIDX=$(($KAFKANODE+$IDX-1))
  NODE="slave-$NODEIDX"
	COUNT=$(($IDX - 1))
	KAFKANAME="kafka$COUNT"
	ORDERER_KAFKA_CONNECT="${ORDERER_KAFKA_CONNECT}$KAFKANAME:9092,"
	KAFKALINK="$KAFKALINK --link $KAFKANAME:$KAFKANAME"
	#ssh $NODE "cd $WORKINGDIR && docker run --rm -it -d --network=$NETWORKNAME --name $KAFKANAME $ZOOKEEPERLINK $KAFKA_BASE_ENV -e KAFKA_BROKER_ID=0 -e KAFKA_ZOOKEEPER_CONNECT='$KAFKACONNECT'  -e KAFKA_REPLICA_FETCH_RESPONSE_MAX_BYTES=\${KAFKA_REPLICA_FETCH_RESPONSE_MAX_BYTES} hyperledger/fabric-kafka"
	ssh $NODE "cd $WORKINGDIR && docker run --rm -it -d --network=$NETWORKNAME --name $KAFKANAME $ZOOKEEPERLINK $KAFKA_BASE_ENV -e KAFKA_BROKER_ID=$COUNT -e KAFKA_ZOOKEEPER_CONNECT=$KAFKACONNECT  hyperledger/fabric-kafka"
	sleep 2s
done
ORDERER_KAFKA_CONNECT="${ORDERER_KAFKA_CONNECT::-1}"
ORDERER_KAFKA_CONNECT="${ORDERER_KAFKA_CONNECT}]"


sleep 6s

#start orderer
ORDERERLINK=""
ORDERER_BASE_ENV=" -p 7050 -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=$NETWORKNAME -e ORDERER_HOME=/var/hyperledger/orderer -e ORDERER_GENERAL_LOGLEVEL=debug -e ORDERER_GENERAL_LOCALMSPDIR=/var/hyperledger/msp -e ORDERER_GENERAL_LOCALMSPID=OrdererMSP -e ORDERER_GENERAL_LISTENADDRESS=0.0.0.0 -e ORDERER_GENERAL_LISTENPORT=7050 -e ORDERER_GENERAL_LEDGERTYPE=ram -e ORDERER_GENERAL_GENESISMETHOD=file -e ORDERER_GENERAL_GENESISFILE=/var/hyperledger/configs/orderer.block -e CONFIGTX_ORDERER_BATCHSIZE_MAXMESSAGECOUNT=\${CONFIGTX_ORDERER_BATCHSIZE_MAXMESSAGECOUNT} -e CONFIGTX_ORDERER_BATCHTIMEOUT=\${CONFIGTX_ORDERER_BATCHTIMEOUT} -e CONFIGTX_ORDERER_ADDRESSES=[127.0.0.1:7050] -e ORDERER_GENERAL_TLS_ENABLED=\${ORDERER_GENERAL_TLS_ENABLED} -e ORDERER_GENERAL_TLS_PRIVATEKEY=\${ORDERER_GENERAL_TLS_PRIVATEKEY} -e ORDERER_GENERAL_TLS_CERTIFICATE=\${ORDERER_GENERAL_TLS_CERTIFICATE} -e ORDERER_GENERAL_TLS_ROOTCAS=[/var/hyperledger/tls/ca.crt] -e ORDERER_TLS_CLIENTAUTHREQUIRED=\${ORDERER_TLS_CLIENTAUTHREQUIRED} -e ORDERER_TLS_CLIENTROOTCAS_FILES=/var/hyperledger/users/Admin@example.com/tls/ca.crt -e ORDERER_TLS_CLIENTCERT_FILE=/var/hyperledger/users/Admin@example.com/tls/client.crt -e ORDERER_TLS_CLIENTKEY_FILE=/var/hyperledger/users/Admin@example.com/tls/client.key"

ORDERER_BASE_ENV="$ORDERER_BASE_ENV -v $WORKINGDIR/../network-config/:/var/hyperledger/configs -v $WORKINGDIR/../crypto-config/ordererOrganizations/example.com/users:/var/hyperledger/users -w /opt/gopath/src/github.com/hyperledger/fabric/orderer"

for IDX in `seq 1 $O`; do
	NODEIDX=$(($ORDERINGNODE+$IDX-1))
  NODE="slave-$NODEIDX"
	COUNT=$(($IDX - 1))
	ORDERERNAME="orderer$COUNT.example.com"
	ORDERER_PORT=${ORDERERPORT[$IDX]}
	ORDERERLINK="$ORDERERLINK --link $ORDERERNAME:$ORDERERNAME"
	ssh $NODE "cd $WORKINGDIR && docker run --rm -it -d --network=$NETWORKNAME --name $ORDERERNAME -p $ORDERER_PORT:7050 $KAFKALINK $ORDERER_BASE_ENV -e ORDERER_HOST=$ORDERERNAME -e CONFIGTX_ORDERER_ORDERERTYPE=kafka -e CONFIGTX_ORDERER_KAFKA_BROKERS=$ORDERER_KAFKA_CONNECT -e ORDERER_KAFKA_RETRY_SHORTINTERVAL=1s -e ORDERER_KAFKA_RETRY_SHORTTOTAL=30s -e ORDERER_KAFKA_VERBOSE=true -e ORDERER_GENERAL_GENESISPROFILE=SampleInsecureKafka -e ORDERER_ABSOLUTEMAXBYTES=\${ORDERER_ABSOLUTEMAXBYTES} -e ORDERER_PREFERREDMAXBYTES=\${ORDERER_PREFERREDMAXBYTES} -v $WORKINGDIR/../crypto-config/ordererOrganizations/example.com/orderers/$ORDERERNAME/msp:/var/hyperledger/msp -v $WORKINGDIR/../crypto-config/ordererOrganizations/example.com/orderers/$ORDERERNAME/tls:/var/hyperledger/tls -v $WORKINGDIR/../network-config/:/var/hyperledger/configs hyperledger/fabric-orderer:1.1.0 orderer"
done


#ssh slave-$STARTNODE "cd $WORKINGDIR && docker run --rm -it -d --network=$NETWORKNAME --name orderer.example.com -p 7050:7050 -e ORDERER_GENERAL_LOGLEVEL=debug -e ORDERER_GENERAL_LISTENADDRESS=0.0.0.0  -e ORDERER_GENERAL_GENESISMETHOD=file -e ORDERER_GENERAL_GENESISFILE=/etc/hyperledger/configtx/orgs.genesis.block -e ORDERER_GENERAL_LOCALMSPID=OrdererMSP -e ORDERER_GENERAL_LOCALMSPDIR=/etc/hyperledger/msp/orderer/msp -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=$NETWORKNAME -w /opt/gopath/src/github.com/hyperledger/fabric -v $WORKINGDIR/../config/:/etc/hyperledger/configtx -v $WORKINGDIR/../config/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp:/etc/hyperledger/msp/orderer/msp hyperledger/fabric-orderer:1.1.0 orderer "

PEER_BASE_ENV="-e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock -e CORE_PEER_NETWORKID=\${CORE_PEER_NETWORKID} -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=$NETWORKNAME -e CORE_PEER_ADDRESSAUTODETECT=true -e CORE_PEER_GOSSIP_ORGLEADER=false -e CORE_PEER_GOSSIP_USELEADERELECTION=true -e CORE_PEER_PROFILE_ENABLED=true -e CORE_PEER_MSPCONFIGPATH=/var/hyperledger/msp -e CORE_LOGGING_LEVEL=DEBUG -e CORE_LOGGING_GOSSIP=\${CORE_LOGGING_GOSSIP} -e CORE_LOGGING_MSP=DEBUG -e CORE_PEER_TLS_ENABLED=\${CORE_PEER_TLS_ENABLED} -e CORE_PEER_TLS_CLIENTAUTHREQUIRED=\${CORE_PEER_TLS_CLIENTAUTHREQUIRED} -e CORE_PEER_TLS_CERT_FILE=\${CORE_PEER_TLS_CERT_FILE} -e CORE_PEER_TLS_KEY_FILE=\${CORE_PEER_TLS_KEY_FILE} -e CORE_PEER_TLS_ROOTCERT_FILE=/var/hyperledger/tls/ca.crt -v /var/run/:/host/var/run/ -v $GOPATH/src/github.com/hyperledger/fabric/:/opt/gopath/src/github.com/hyperledger/fabric/ -v $WORKINGDIR/../network-config/:/var/hyperledger/configs "

#start peer0.org1.example.com
for IDX in `seq 1 $N`; do
	NODEIDX=$(($STARTNODE+$IDX-1))
	NODE="slave-$NODEIDX"
	PEERNAME="peer0.org$IDX.example.com"
	PEER_REQ=${PEERREQ[$IDX]}
	PEER_EVENT=${PEEREVENT[$IDX]}
	ssh $NODE "cd $WORKINGDIR && docker run --rm -it -d --network=$NETWORKNAME --name $PEERNAME -p $PEER_REQ:7051 -p $PEER_EVENT:7053 $ORDERERLINK  $PEER_BASE_ENV -e CORE_PEER_CHAINCODELISTENADDRESS=$PEERNAME:7052 -e CORE_PEER_ID=$PEERNAME -e CORE_PEER_ADDRESS=$PEERNAME:7051 -e CORE_PEER_GOSSIP_EXTERNALENDPOINT=$PEERNAME:7051 -e CORE_PEER_GOSSIP_ORGLEADER=false -e CORE_PEER_GOSSIP_USELEADERELECTION=true -e CORE_PEER_LOCALMSPID=Org${IDX}MSP -e CORE_PEER_TLS_CLIENTROOTCAS_FILES=/var/hyperledger/users/Admin@org$IDX.example.com/tls/ca.crt -e CORE_PEER_TLS_CLIENTCERT_FILE=/var/hyperledger/users/Admin@org$IDX.example.com/tls/client.crt -e CORE_PEER_TLS_CLIENTKEY_FILE=/var/hyperledger/users/Admin@org$IDX.example.com/tls/client.key  -v $WORKINGDIR/../crypto-config/peerOrganizations/org$IDX.example.com/peers/$PEERNAME/msp:/var/hyperledger/msp -v $WORKINGDIR/../crypto-config/peerOrganizations/org$IDX.example.com/peers/$PEERNAME/tls:/var/hyperledger/tls -v $WORKINGDIR/../crypto-config/peerOrganizations/org$IDX.example.com/users:/var/hyperledger/users  hyperledger/fabric-peer:1.1.0 peer node start"

	#ssh $NODE "cd $WORKINGDIR && docker run --rm -it -d --link orderer.example.com:orderer.example.com $PEERLINK  --network=$NETWORKNAME --name $PEERNAME -p $PEER_REQ:7051 -p $PEER_EVENT:7053 -e CORE_LOGGING_PEER=debug -e CORE_CHAINCODE_LOGGING_LEVEL=DEBUG -e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock -e CORE_PEER_ID=$PEERNAME -e CORE_PEER_ENDORSER_ENABLED=true -e CORE_PEER_ADDRESS=$PEERNAME:7051 -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=$NETWORKNAME -e CORE_PEER_LOCALMSPID=Org"$IDX"MSP -e CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/peer/msp -e CORE_PEER_GOSSIP_USELEADERELECTION=true -e CORE_PEER_GOSSIP_ORGLEADER=false -e CORE_PEER_GOSSIP_EXTERNALENDPOINT=$PEERNAME:7051  -w /opt/gopath/src/github.com/hyperledger/fabric  -v /var/run/:/host/var/run/ -v $WORKINGDIR/../config/mychannel.tx:/etc/hyperledger/configtx/mychannel.tx -v $WORKINGDIR/../config/crypto-config/peerOrganizations/org$IDX.example.com/peers/$PEERNAME/msp:/etc/hyperledger/peer/msp -v $WORKINGDIR/../config/crypto-config/peerOrganizations/org$IDX.example.com/users:/etc/hyperledger/msp/users  hyperledger/fabric-peer:1.1.0 peer node start"
done

#start peer0.org2.example.com

#docker run --rm -it --link orderer.example.com:orderer.example.com --link peer0.org1.example.com:peer0.org1.example.com --network="my-net" --name peer0.org2.example.com -p 8051:7051 -p 8053:7053 -e CORE_LOGGING_PEER=debug -e CORE_CHAINCODE_LOGGING_LEVEL=DEBUG -e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock -e CORE_PEER_ID=peer0.org2.example.com -e CORE_PEER_ENDORSER_ENABLED=true -e CORE_PEER_ADDRESS=peer0.org2.example.com:7051 -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=my-net -e CORE_PEER_LOCALMSPID=Org2MSP -e CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/peer/msp -e CORE_PEER_GOSSIP_USELEADERELECTION=true -e CORE_PEER_GOSSIP_ORGLEADER=false -e CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer0.org2.example.com:7051  -w /opt/gopath/src/github.com/hyperledger/fabric  -v /var/run/:/host/var/run/ -v $(pwd)/../config/mychannel.tx:/etc/hyperledger/configtx/mychannel.tx -v $(pwd)/../config/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp:/etc/hyperledger/peer/msp -v $(pwd)/../config/crypto-config/peerOrganizations/org2.example.com/users:/etc/hyperledger/msp/users  hyperledger/fabric-peer:1.1.0 peer node start
