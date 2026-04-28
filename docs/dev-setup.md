# Developer Setup

## Prerequisites

| Tool | Version |
|---|---|
| Rust | 1.78+ |
| wasm32 target | via rustup |
| Soroban CLI | 21+ |
| Flutter | 3.22+ |

## Contract setup

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup target add wasm32-unknown-unknown
cargo install --locked soroban-cli@21.0.0
```

Build and deploy to testnet:

```bash
cd contracts/guardian
soroban contract build
soroban contract deploy \
  --network testnet \
  --wasm target/wasm32-unknown-unknown/release/guardian.wasm
```

Run contract tests:

```bash
cargo test
```

## Flutter app setup

Install Flutter following the [official guide](https://docs.flutter.dev/get-started/install) for your platform, then:

```bash
cd app
flutter pub get
flutter run -d chrome   # parent web build
flutter run             # connected device
```

## Environment

Copy `.env.example` to `.env` and fill in the Soroban contract address once deployed.
