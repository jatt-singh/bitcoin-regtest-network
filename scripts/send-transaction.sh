#!/bin/bash
set -e

echo "Checking for existing wallet on node2..."
docker exec node2 bitcoin-cli -regtest -rpcuser=admin -rpcpassword=pass listwallets | grep -q node2wallet || \
  docker exec node2 bitcoin-cli -regtest -rpcuser=admin -rpcpassword=pass createwallet node2wallet

echo "Generating new address on node2..."
TO_ADDR=$(docker exec node2 bitcoin-cli -regtest -rpcuser=admin -rpcpassword=pass getnewaddress)
echo "Sending 1 BTC to $TO_ADDR"

TXID=$(docker exec node1 bitcoin-cli -regtest -rpcuser=admin -rpcpassword=pass sendtoaddress "$TO_ADDR" 1.0)
echo "Transaction sent. TXID: $TXID"

echo "Mining 1 block to confirm the transaction..."
CONFIRM_ADDR=$(docker exec node1 bitcoin-cli -regtest -rpcuser=admin -rpcpassword=pass getnewaddress)
BLOCK_HASH=$(docker exec node1 bitcoin-cli -regtest -rpcuser=admin -rpcpassword=pass generatetoaddress 1 "$CONFIRM_ADDR")

echo "Transaction confirmed in block: $BLOCK_HASH"
