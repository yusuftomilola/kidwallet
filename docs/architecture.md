# Architecture

## Overview

KidWallet consists of two main components:

1. **Guardian Contract** - a Soroban smart contract on the Stellar network that manages allowances, spending limits, and fund transfers.
2. **Flutter App** - a cross-platform mobile application for parents and children to interact with the guardian contract.

## Component Diagram

```
+---------------------+         +--------------------------+
|    Flutter App      | ------> |   Guardian Contract      |
|  (Mobile Client)   |  RPC    |   (Soroban / Stellar)    |
+---------------------+         +--------------------------+
```

## Guardian Contract

- Located in `contracts/guardian/`
- Written in Rust, compiled to WebAssembly for the Stellar network
- Manages: depositing funds, setting spending limits, and authorising withdrawals

## Flutter App

- Located in `app/`
- Built with Flutter 3.x targeting Android and iOS
- Communicates with the Stellar network via Horizon RPC
- Provides separate views for guardian (parent) and child accounts
