#!/bin/bash
set -e

echo "Waiting for bitcoind nodes to start..."
sleep 5

# Create wallet and mine 101 blocks on node1
echo "Creating wallet on node1..."
docker exec node1 bitcoin-cli -regtest -rpcuser=admin -rpcpassword=pass createwallet node1wallet

echo "Mining 101 blocks on node1..."
ADDR=$(docker exec node1 bitcoin-cli -regtest -rpcuser=admin -rpcpassword=pass getnewaddress)
docker exec node1 bitcoin-cli -regtest -rpcuser=admin -rpcpassword=pass generatetoaddress 101 $ADDR

# Connect node2 to node1
echo "Connecting node2 to node1..."
docker exec node2 bitcoin-cli -regtest -rpcuser=admin -rpcpassword=pass addnode "node1:18444" "onetry"

echo "Setup complete!"
