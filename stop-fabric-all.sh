#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: $0 <Start Node> <End Node>"
	exit 1
fi
START=$1
END=$2
set -x

STARTNODE=32
ORDERINGNODE=16
NETWORKNAME="my-net"
WORKINGDIR="$HOME/caliper/network/fabric-v1.1/2org1peergoleveldb"
PEERLINK=""

for IDX in `seq $START $END`; do
	#NODEIDX=$(($STARTNODE+$IDX-1))
        #NODE="slave-$NODEIDX"
	NODE="slave-$IDX"
	ssh $NODE "docker stop \$(docker ps -aq)"
	ssh $NODE "docker rm \$(docker ps -aq)"
done

