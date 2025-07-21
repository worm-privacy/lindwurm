#!/bin/bash

set -e

CMD=$1
NETWORK=$2
PRIVATE_KEY=$3

if [[ -z "$PRIVATE_KEY" || -z "$NETWORK" ]]; then
  echo "❌ Error: Missing required arguments."
  echo "Usage:"
  echo "  docker run ... burn <network> <private_key> [amount] [spend] [fee]"
  echo "  docker run ... info <network> <private_key>"
  echo "  docker run ... mine <network> <private_key> [min] [max] [price] [epochs] [custom_rpc]"
  echo "  docker run ... participate <network> <private_key> [amount_per_epoch] [num_epochs]"
  echo "  docker run ... claim <network> <private_key> [from_epoch] [num_epochs]"
  exit 1
fi

case "$CMD" in
  burn)
    AMOUNT=${4:-1.0}
    SPEND=${5:-1.0}
    FEE=${6:-0}
    worm-miner burn --network "$NETWORK" --private-key "$PRIVATE_KEY" --amount "$AMOUNT" --spend "$SPEND" --fee "$FEE"
    ;;
  participate)
    AMOUNT_PER_EPOCH=${4:-1.0}
    NUM_EPOCHS=${5:-1.0}
    worm-miner participate --network "$NETWORK" --private-key "$PRIVATE_KEY" --amount-per-epoch "$AMOUNT_PER_EPOCH" --num-epochs "$NUM_EPOCHS"
    ;;
  claim)
    FROM_EPOCH=${4:-1.0}
    NUM_EPOCHS=${5:-1.0}
    worm-miner claim --network "$NETWORK" --private-key "$PRIVATE_KEY" --from-epoch "$FROM_EPOCH" --num-epochs "$NUM_EPOCHS"
    ;;
  info)
    worm-miner info --network "$NETWORK" --private-key "$PRIVATE_KEY"
    ;;
  mine)
    MIN=${4:-0.0001}
    MAX=${5:-0.01}
    PRICE=${6:-0.000002}
    EPOCHS=${7:-3}
    CUSTOM_RPC=${8:-}

    CMD="worm-miner mine --network \"$NETWORK\" --private-key \"$PRIVATE_KEY\" \
         --min-beth-per-epoch \"$MIN\" --max-beth-per-epoch \"$MAX\" \
         --assumed-worm-price \"$PRICE\" --future-epochs \"$EPOCHS\""

    if [[ -n "$CUSTOM_RPC" ]]; then
      CMD="$CMD --custom-rpc \"$CUSTOM_RPC\""
    fi

    eval $CMD
    ;;
  *)
    echo "❌ Unknown command: $CMD"
    echo "Valid commands are: burn, info, mine, participate, claim"
    exit 1
    ;;
esac
