# 🐉 Lindwurm 🪱

Here you will find the instructions to participate in the Lindwurm incentivized testnet! Users who will help us in testing the network may earn community allocations of the future WORM token!

In order to participate in the testnet you'll need:

- [x] An x86-64 machine or VPS or dedicated-server with at least 16GB of RAM (***WARN:*** ARM / Apple Silicon devices are not supported!)
- [x] At least 1.0 Sepolia ETH which you may get from Sepolia faucets

Test on Debian/Ubuntu systems:

1. Install requirements:
   ```
   sudo apt install -y build-essential cmake libgmp-dev libsodium-dev nasm curl m4 git wget unzip nlohmann-json3-dev
   ```
3. Install Rust toolchain:
   ```
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```
5. Clone the repo:
   ```
   git clone https://github.com/worm-privacy/miner && cd miner
   ```
7. Download parameters files:
   ```
   make download_params
   ```
9. Install `worm-miner`:
   ```
   cargo install --path .
   ```
10. Burn some ETH and generate and submit a proof:
    ```
    worm-miner burn --network sepolia --private-key [YOUR SEPOLIA PRIVATE KEY] --amount 1.0 --spend 1.0 --fee 0
    ```
11. Congrats! 1.0 BETH has been minted for `0x90F8bf6A479f320ead074411a4B0e7944Ea8c9C1`! Check by running:
    ```
    worm-miner info --network sepolia --private-key [YOUR SEPOLIA PRIVATE KEY]
    ```
12. Now run the miner:
    ```
    worm-miner mine --network sepolia --private-key [YOUR SEPOLIA PRIVATE KEY] --min-beth-per-epoch 0.0001 --max-beth-per-epoch 0.01 --assumed-worm-price 0.000002 --future-epochs 3
    ```
    Where:
      - `--min-beth-per-epoch` is the min amount of BETH you are willing to consume in order to participate in any block.
      - `--max-beth-per-epoch` is the max amount of BETH you are willing to consume in order to participate in any block.
      - `--assumed-worm-price` is your assumed WORM/ETH pair price.
      - `--future-epochs` is the number of epochs you would like to participate in in advance.
13. Let us know your Sepolia address on X!

## Or

Test on Docker Container:

### Prerequisites:
- Install Docker on your machine (Windows, Mac, or Linux).  
  See [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/) for installation instructions.

1. clone this repo with:  
   ```
   git clone https://github.com/worm-privacy/lindwurm.git && cd lindwurm
   ```

2. Build the docker container:
   ```
   docker build -t lindwurm-miner .
   ```

3. Burn some ETH and generate and submit a proof:
    ```
    docker run --rm lindwurm-miner burn sepolia [YOUR SEPOLIA PRIVATE KEY] 1.0 1.0 0
    ```

4. Congrats! 1.0 BETH has been minted for `0x90F8bf6A479f320ead074411a4B0e7944Ea8c9C1`! Check by running:
    ```
    docker run --rm lindwurm-miner info sepolia [YOUR SEPOLIA PRIVATE KEY]
    ```
5. Now run the miner:
    ```
    docker run --rm lindwurm-miner mine sepolia [YOUR SEPOLIA PRIVATE KEY] 0.0001 0.01 0.000002 3 [OPTIONAL: CUSTOM SEPOLIA RPC URL]
    ```
