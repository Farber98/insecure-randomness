# Insecure source of randomness

Creating a strong enough source of randomness in Ethereum is very challenging. Next, we will see why you shouldn't rely on block values as a secure source of randomness (eg. block.timestamp, blockhash, block.difficulty).

## Reproduction

### 📜 Involves two smart contracts.

    1. A vulnerable contract that uses block values as a source of randomness.
    2. A malicious contract that calculates these values and calls the vulnerable contract.

## How to prevent it

👁️ Don't use block values as a secure source of randomness
