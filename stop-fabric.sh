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

for IDX in `seq 1 $N`; do
	NODEIDX=$(($STARTNODE+$IDX-1))
        NODE="slave-$NODEIDX"
	ssh $NODE "docker stop \$(docker ps -aq)"
	ssh $NODE "docker rm \$(docker ps -aq)" 
done
