#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: $0 <# of nodes>"
	exit 1
fi
N=$1
O=$2
set -x

STARTNODE=20
ORDERINGNODE=30
NETWORKNAME="my-net"
WORKINGDIR="$HOME/caliper/network/fabric-v1.1/2org1peergoleveldb"
PEERLINK=""

for IDX in `seq 1 $N`; do
	NODEIDX=$(($STARTNODE+$IDX-1))
        NODE="slave-$NODEIDX"
	ssh $NODE "docker stop \$(docker ps -aq)"
	ssh $NODE "docker rm \$(docker ps -aq)"
done

for IDX in `seq 1 $O`; do
	NODEIDX=$(($ORDERINGNODE+$IDX-1))
        NODE="slave-$NODEIDX"
	ssh $NODE "docker stop \$(docker ps -aq)"
	ssh $NODE "docker rm \$(docker ps -aq)"
done
