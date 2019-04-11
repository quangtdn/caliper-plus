# caliper-plus

To set up a customized fabric network:

1) Generate 2 config files `configtx.yaml` and `crypto-config.yaml` describing the network topology by running:

```
yarn genConfig -domain example.com -Kafka 3 -Orderer 4 -Zookeeper 3 -Orgs 3 -Peer 1 -Tag :1.1.0
```

These 2 files are meant to only describe the network topology and settings. The config files used by a fabric network are different.


2) Generate the config folders for bringing up a fabric network. The script uses the crypto-gen tools of Hyperledger Fabric to consume the 2 above files configtx.yaml and crypto-config.yaml and output the config folders for bringing up a fabric network. 

```
./generate.sh
```

3) Init/start/bring up the fabric network:

```
./init-fabric.sh
```

E.g. to bring up a network with 3 peers, 4 kafka brokers, 3 orderers, 3 zookeepers:

```
./init-fabric-kafka.sh  3 4 3 3
```

4) Use Caliper to benchmark the fabric network.

```
cd caliper
rm -rf /tmp/hfc-*
npm run bench -- -c benchmark/simple/config.yaml -n network_testing-kafka/fabric-ccp-3orderers-3org1peer-mynet.yaml
```

5) Stopping and removing containers:

```
./stop-fabric.sh 10 10
```
