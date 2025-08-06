# Bitcoin Regtest Network with Docker

This project sets up a **private Bitcoin network (regtest)** using **Docker** and **bitcoin-core**. It launches **two Bitcoin nodes**, connects them, mines blocks, and performs a transaction between the nodes all through automated **bash scripts**.


---

## Features

-  Runs two Bitcoin Core nodes in Docker containers
-  Automated setup with bash scripts
-  Mines blocks to unlock coinbase transactions
-  Sends transactions between nodes
-  Scripts are reusable — generate a new transaction every time
-  Easy to extend and integrate into CI/CD pipelines

---

## Project Structure

```bash
.
├── docker-compose.yml         # Docker config for two bitcoin-core nodes
├── node1/                     # Persistent data for node1
├── node2/                     # Persistent data for node2
├── scripts/
│   ├── setup-network.sh       # Starts the network, mines blocks, connects nodes
│   └── send-transaction.sh    # Sends 1 BTC from node1 to node2 and confirms it
└── README.md


# Prerequisites

## Make sure you have the following installed:

 - Docker
 - Bash shell (Linux/macOS)

# Steps

## Step 1: Clone the Repository

`git clone https://github.com/YOUR_USERNAME/bitcoin-regtest-docker.git
 cd bitcoin-regtest-docker
`

## Step 2: Start the Docker Containers

`
docker compose up -d
`
 - This will launch node1 and node2 using the ruimarinho/bitcoin-core Docker image.
 - You can confirm the containers are running using:

`
 docker ps
`

## Step 3: Set Up the Regtest Network
 - Run the setup script:
`
  ./scripts/setup-network.sh
`
 - This will:
    - Create a wallet on node1
    - Mine 101 blocks to unlock coinbase rewards
    - Connect node1 to node2

## Step 4: Send a Transaction

 - To send 1 BTC from node1 to node2, run:

`
 ./scripts/send-transaction.sh
`
 - This script will:
    - Create a wallet on node2 (if not already created)
    - Generate a receiving address on node2
    - Send 1 BTC from node1 to that address
    - Mine 1 block to confirm the transaction

    You can run this script multiple times to simulate additional transactions.

## Step 5: (Optional) Check Balances
- You can verify the balances using:

# Check node1 balance
`
 docker exec node1 bitcoin-cli -regtest -rpcuser=admin -rpcpassword=pass getbalance
`

# Check node2 balance
`
 docker exec node2 bitcoin-cli -regtest -rpcuser=admin -rpcpassword=pass getbalance
`

## Step 6: Stop and Clean Up
 - To stop and remove the containers and reset all data, run:
`
 docker compose down -v
`

 - This clears all blockchain and wallet data.

