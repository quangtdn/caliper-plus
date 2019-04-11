./init-fabric-kafka.sh 24 4 4 3 
./stop-fabric-all.sh 10 49 
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 4 8 4 3
./stop-fabric-all.sh 10 49 
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 4 8 4 3
./stop-fabric-all.sh 10 49 
./init-fabric-kafka.sh 8 8 4 3
./stop-fabric-all.sh 10 49 
./init-fabric-kafka.sh 16 8 4 3
./stop-fabric-all.sh 10 49 
./init-fabric-kafka.sh 16 8 4 3
ssh slave-16
ssh slave-17
ssh slave-10
./stop-fabric-all.sh 10 49 
./init-fabric-kafka.sh 16 8 4 3
./stop-fabric-all.sh 10 49 
./init-fabric-kafka.sh 20 8 4 3
./stop-fabric-all.sh 10 49 
./init-fabric-kafka.sh 4 16 4 3
./stop-fabric-all.sh 10 49 
vim init-fabric-kafka.sh 
./init-fabric-kafka.sh 4 16 4 3
./stop-fabric-all.sh 10 49 
vim init-fabric-kafka.sh 
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 16 16 4 3
./stop-fabric-all.sh 10 49 
./init-fabric.sh 
./init-fabric.sh 16
ssh slave-10
ssh slave-16
ssh slave-17
vim init-fabric-kafka.sh 
./stop-fabric 10 49
./stop-fabric-all.sh 10 33
./init-fabric.sh 16 
ssh slave-16
ssh slave-10
ssh slave-16
ssh slave-10
ssh slave-16
ssh slave-10
ssh slave-17
ssh slave-16
./stop-fabric-all.sh 10 33
./init-fabric.sh 16 
./init-fabric.sh 16 
./init-fabric.sh 16 
./stop-fabric 10 34
./stop-fabric-all.sh 10 34
./init-fabric.sh 16 
./stop-fabric-all.sh 10 34
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 8 16 4 3
./stop-fabric-all.sh 10 49 
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 24 8 4 3 
cd kafka-network/24peer4ord16kafka/
vim configtx.yaml 
./generate.sh 
cd ..
cd ..
vim init-fabric-kafka.sh 
cd kafka-network/20peer4ord4kafka/
vim configtx.yaml 
ssh slave-14
cd caliper/
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-24host.yaml -n network-kafka/24peer4ord8kafka/fabric-ccp-mynet-created.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-24host.yaml -n network-kafka/24peer4ord8kafka/fabric-ccp-mynet-created.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-24host.yaml -n network-kafka/24peer4ord8kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-24host.yaml -n network-kafka/24peer4ord8kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-20host.yaml -n network-kafka/20peer4ord4kafka/fabric-ccp-mynet.yaml
./stop-fabric-all.sh 10 49
cd kafka-network/20peer4ord16kafka/
vim configtx.yaml 
rm -rf crypto-config
./generate.sh 
lsb_release -a
cd kafka-network/12peer4ord4kafka/
vim configtx.yaml 
rm -rf crypto-config
./generate.sh 
docker logs peer0.org1.example.com 
exit
docker logs orderer0.example.com 
exit
docker logs kafka1 
exit
ssh slave-16
ssh slave-10
ssh slave-34
ssh slave-16
docker logs peer0.org1.example.com 
ssh slave-16
docker logs peer0.org1.example.com 
cd kafka-network/12peer4ord8kafka/
vim configtx.
vim configtx.yaml 
rm -rf crypto-config
./generate.sh 
cd ..
cd 12peer4ord16kafka/
vim configtx.yaml 
vim configtx.yaml 
./generate.sh 
ssh slave-11
ssh slave-16
docker logs orderer1.example.com 
docker logs peer0.org1.example.com 
docker logs orderer1.example.com 
exit
docker logs orderer0.example.com 
exit
?
vim init-fabric-kafka.sh 
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 20 16 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 24 16 4 3 
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 4 4 4 3 
./stop-fabric-all.sh 10 49
:D
./init-fabric-kafka.sh  
./init-fabric-kafka.sh 8 4 4 3 
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 16 4 4 3 
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 8 4 4 3 
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 12 4 4 3 
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 16 4 4 3 
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh  
./init-fabric-kafka.sh  4 8 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh  8 8 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh  12 8 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh  12 16 4 3
ssh slave-14
cd caliper/
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-16host.yaml -n network-kafka/16peer4ord16kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-16host.yaml -n network-kafka/16peer4ord16kafka/fabric-ccp-mynet-created.yaml
npm run bench -- -c benchmark-kafka/smallbank/saturate-16host.yaml -n network-kafka/16peer4ord16kafka/fabric-ccp-mynet-created.yaml
cd caliper/
rm -rf /tmp/hfc-* 
ssh slave-14
cd caliper/
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-20host.yaml -n network-kafka/20peer4ord16kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-20host.yaml -n network-kafka/20peer4ord16kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-20host.yaml -n network-kafka/20peer4ord16kafka/fabric-ccp-mynet-created.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-24host.yaml -n network-kafka/24peer4ord16kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/clientrate300tps-4host.yaml -n network-kafka/4peer4ord3kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-4host.yaml -n network-kafka/4peer4ord3kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-4host.yaml -n network-kafka/4peer4ord4kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-8host.yaml -n network-kafka/8peer4ord4kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-12host.yaml -n network-kafka/12peer4ord4kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-8host.yaml -n network-kafka/8peer4ord4kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-8host.yaml -n network-kafka/8peer4ord4kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-12host.yaml -n network-kafka/12peer4ord4kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-12host.yaml -n network-kafka/12peer4ord4kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-12host.yaml -n network-kafka/12peer4ord4kafka/fabric-ccp-mynet-created.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-12host.yaml -n network-kafka/16peer4ord4kafka/fabric-ccp-mynet-created.yaml
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-16host.yaml -n network-kafka/16peer4ord4kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-16host.yaml -n network-kafka/16peer4ord4kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-4host.yaml -n network-kafka/4peer4ord8kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-8host.yaml -n network-kafka/8peer4ord8kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-12host.yaml -n network-kafka/12peer4ord8kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-12host.yaml -n network-kafka/12peer4ord8kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-12host.yaml -n network-kafka/12peer4ord8kafka/fabric-ccp-mynet-created.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-16host.yaml -n network-kafka/12peer4ord16kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-16host.yaml -n network-kafka/12peer4ord16kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-12host.yaml -n network-kafka/12peer4ord16kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-12host.yaml -n network-kafka/12peer4ord16kafka/fabric-ccp-mynet-created.yaml
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-12host.yaml -n network-kafka/12peer4ord16kafka/fabric-ccp-mynet-created.yaml
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-12host.yaml -n network-kafka/12peer4ord16kafka/fabric-ccp-mynet-created.yaml
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 16 16 4 3
ssh slave-11
docker logs orderer1.example.com 
docker logs orderer1.example.com 
docker logs orderer1.example.com 
docker logs orderer1.example.com 
docker logs orderer1.example.com 
exit
docker logs orderer0.example.com 
exit
docker logs orderer1.example.com 
exit
./stop-fabric-all.sh 10 49
ssh slave-10
vim init-fabric-kafka.sh 
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 16 16 4 3
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 16 16 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 16 16 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 16 16 4 3
./stop-fabric-all.sh 10 49
vim init-fabric-kafka.sh 
ssh slave-11
ssh slave-10
vim init-fabric-kafka.sh 
vim init-fabric-kafka.sh 
ssh slave-11
vim init-fabric-kafka.
vim init-fabric-kafka.sh 
vim init-fabric-kafka.sh 
exit
exit
vim init-fabric-kafka.sh 
ssh slave-24
cd caliper/
rm -rf /tmp/hfc-* 
ssh slave-10
docker logs orderer0.example.com 
ssh slave-14
cd caliper/
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/saturate-16host.yaml -n network-kafka/16peer4ord16kafka/fabric-ccp-mynet.yaml
docker logs orderer0.example.com 
exit
exit
ssh slave-10
ssh slave-10
ssh slave-16
docker logs peer0.org1.example.com 
ssh slave-14
cd caliper/
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-16host.yaml -n network-kafka/16peer4ord8kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-16host.yaml -n network-kafka/16peer4ord16kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-16host.yaml -n network-kafka/16peer4ord16kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-8host.yaml -n network-kafka/8peer4ord16kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-8host.yaml -n network-kafka/8peer4ord16kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-8host.yaml -n network-kafka/8peer4ord16kafka/fabric-ccp-mynet-created.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-16host.yaml -n network-kafka/16peer4ord8kafka/fabric-ccp-mynet.yaml
docker logs orderer0.example.com 
ssh slave-16
ssh slave-17
ssh slave-17
docker logs peer0.org2.example.com 
./stop-fabric-all.sh 10 49
vim init-fabric-kafka.sh 
vim init-fabric-kafka.sh 
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 16 8 4 3 
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh  
./init-fabric-kafka.sh  16 16 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh  8 16 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh  16 8 4 3
ssh slave-14
cd caliper/
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-16host.yaml -n network-kafka/16peer4ord8kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate300tps-16host.yaml -n network-kafka/16peer4ord8kafka/fabric-ccp-mynet-created.yaml
ssh slave-10
./stop-fabric-all.sh 10 49
docker logs orderer0.example.com 
exit
docker logs orderer0.example.com 
exit
ssh slave-10
vim init-fabric-kafka.sh 
ssh slave-10
vim init-fabric-kafka.sh 
ssh slave-14
cd caliper/
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/saturate-16host.yaml -n network-kafka/16peer4ord16kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/saturate-16host.yaml -n network-kafka/16peer4ord16kafka/fabric-ccp-mynet.yaml
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 16 16 4 3
./stop-fabric-all.sh 10 49
vim init-fabric-kafka.sh 
./init-fabric-kafka.sh 16 16 4 3
vim init-fabric-kafka.sh 
./stop-fabric-all.sh 10 49
ssh slave-14
cd caliper/
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-4host.yaml -n network-kafka/4peer4ord4kafka/fabric-ccp-mynet.yaml
cd caliper/
ls
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-4host.yaml -n network-kafka/4peer4ord4kafka/fabric-ccp-mynet-created.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-8host.yaml -n network-kafka/8peer4ord4kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-16host.yaml -n network-kafka/16peer4ord4kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-20host.yaml -n network-kafka/20peer4ord4kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-24host.yaml -n network-kafka/24peer4ord4kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-4host.yaml -n network-kafka/4peer4ord8kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-4host.yaml -n network-kafka/4peer4ord8kafka/fabric-ccp-mynet-created.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-20host.yaml -n network-kafka/20peer4ord4kafka/fabric-ccp-mynet-created.yaml
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-20host.yaml -n network-kafka/20peer4ord4kafka/fabric-ccp-mynet.yaml
exit
ssh slave-14
exit
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh
./init-fabric-kafka.sh 8 4 4 3 
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 16 4 4 3 
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 20 4 4 3 
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 24 4 4 3 
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh  
./init-fabric-kafka.sh  4 8 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh  
./init-fabric-kafka.sh  20 4 4 3
exit
./stop-fabric-all.sh 10 49
vim init-fabric-kafka.sh 
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 4 4 4 3
exit
vim init-fabric-kafka.sh 
ssh sslave-16
ssh slave-16
ssh sslave-17
ssh slave-17
ssh slave-14
cd caliper/
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-20host.yaml -n network-kafka/20peer4ord8kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-4host.yaml -n network-kafka/4peer4ord16kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-20host.yaml -n network-kafka/20peer4ord16kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/clientrate30tps-20host.yaml -n network-kafka/20peer4ord16kafka/fabric-ccp-mynet.yaml
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 20 8 4 3 
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 4 16 4 3 
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 20 16 4 3 
./stop-fabric-all.sh 10 49
exit
ssh slave-17
docker logs peer0.org2.example.com 
./stop-fabric-all.sh 10 49
cd caliper/
cd ..
ssh slave-14
cd caliper/
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-8host.yaml -n network-kafka/8peer4ord8kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-16host.yaml -n network-kafka/16peer4ord8kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-20host.yaml -n network-kafka/20peer4ord8kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-20host.yaml -n network-kafka/20peer4ord8kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-20host.yaml -n network-kafka/20peer4ord8kafka/fabric-ccp-mynet-created.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-24host.yaml -n network-kafka/24peer4ord8kafka/fabric-ccp-mynet-created.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-24host.yaml -n network-kafka/24peer4ord8kafka/fabric-ccp-mynet-created.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-24host.yaml -n network-kafka/24peer4ord8kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-4host.yaml -n network-kafka/4peer4ord16kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-4host.yaml -n network-kafka/4peer4ord16kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-4host.yaml -n network-kafka/4peer4ord16kafka/fabric-ccp-mynet-created.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-8host.yaml -n network-kafka/8peer4ord16kafka/fabric-ccp-mynet-created.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-8host.yaml -n network-kafka/8peer4ord16kafka/fabric-ccp-mynet-created-created.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-8host.yaml -n network-kafka/8peer4ord16kafka/fabric-ccp-mynet-created.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-8host.yaml -n network-kafka/8peer4ord16kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-16host.yaml -n network-kafka/16peer4ord16kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-20host.yaml -n network-kafka/20peer4ord16kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 8 8 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 16 8 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 20 8 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 24 8 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 4 16 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 8 16 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 16 16 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 20 16 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 24 16 4 3
ssh slave-10
docker logs orderer0.example.com 
ssh slave-10
docker logs orderer0.example.com 
ssh slave-10
docker logs orderer0.example.com 
ssh slave-10
docker logs orderer0.example.com 
ssh slave-10
docker logs orderer0.example.com 
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 
./init-fabric-kafka.sh 4 4 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 8 4 8 3
./init-fabric-kafka.sh 8 8 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 8 16 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 16 16 4 3
./stop-fabric-all.sh 10 49
./init-fabric-kafka.sh 24 16 4 3
ssh slave-10
docker logs orderer0.example.com 
ssh sslave-16
ssh slave-16
ssh slave-14
cd caliper/
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-24host.yaml -n network-kafka/24peer4ord16kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-4host.yaml -n network-kafka/4peer4ord4kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-8host.yaml -n network-kafka/8peer8ord4kafka/fabric-ccp-mynet.yaml
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-8host.yaml -n network-kafka/8peer4ord8kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-8host.yaml -n network-kafka/8peer4ord16kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-16host.yaml -n network-kafka/16peer4ord16kafka/fabric-ccp-mynet.yaml
rm -rf /tmp/hfc-* 
npm run bench -- -c benchmark-kafka/smallbank/fixrate400tps-24host.yaml -n network-kafka/24peer4ord16kafka/fabric-ccp-mynet.yaml
ls
cd caliper/
cd ..
./stop-fabric-all.sh 10 49
vim init-fabric-kafka.sh 
cd /users/quangtdn/kafka-network/
ls
cd ..
cd kafka-network/
ls
cd kafka-network/
ls
cd ..
cd caliper/
cd network-kafka/
ls
cd ..
cd ..
cd caliper/network-kafka/
ls
cd 24peer4ord16kafka/
ls
cd ..
cd ..
cd ..
exit
