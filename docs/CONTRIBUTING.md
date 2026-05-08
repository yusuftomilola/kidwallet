# Contributing to KidWallet

Thank you for contributing to KidWallet 🚀

This guide explains the development workflow, repository structure, setup instructions, Cargo workspace usage, and contribution standards for the project.

---

# Table of Contents

- [Project Overview](#project-overview)
- [Repository Structure](#repository-structure)
- [Prerequisites](#prerequisites)
- [Initial Setup](#initial-setup)
- [Cargo Workspace Workflow](#cargo-workspace-workflow)
- [Flutter App Setup](#flutter-app-setup)
- [Smart Contract Development](#smart-contract-development)
- [Development Commands](#development-commands)
- [Linting & Formatting](#linting--formatting)
- [Testing](#testing)
- [Branch Naming Convention](#branch-naming-convention)
- [Commit Message Convention](#commit-message-convention)
- [Pull Request Guidelines](#pull-request-guidelines)
- [Code Review Expectations](#code-review-expectations)
- [Issue Workflow](#issue-workflow)
- [Security Guidelines](#security-guidelines)

---

# Project Overview

KidWallet is a blockchain-powered wallet application focused on secure financial access and smart contract interactions.

The repository contains:

- Flutter mobile application
- Rust smart contracts
- Cargo workspace configuration
- Shared project documentation
- GitHub workflows and CI automation

The project emphasizes:
- Security
- Clean architecture
- Developer experience
- Maintainable contributions
- Predictable workflows

---

# Repository Structure

```bash
.
├── .github/              # GitHub workflows and templates
├── app/                  # Flutter mobile application
├── contracts/            # Rust smart contracts
├── docs/                 # Project documentation
├── Cargo.toml            # Cargo workspace root
├── README.md
└── LICENSE
```

---

# Prerequisites

Install the following tools before contributing:

| Tool | Recommended Version |
|------|----------------------|
| Flutter | >= 3.x |
| Dart | bundled with Flutter |
| Rust | stable |
| Cargo | latest |
| Git | latest |

---

# Initial Setup

## 1. Clone the Repository

```bash
git clone https://github.com/<your-org>/kidwallet.git
cd kidwallet
```

---

## 2. Install Flutter Dependencies

```bash
cd app
flutter pub get
```

---

## 3. Verify Flutter Installation

```bash
flutter doctor
```

Resolve all critical issues before development.

---

## 4. Install Rust Toolchain

```bash
rustup update
cargo --version
```

---

# Cargo Workspace Workflow

KidWallet uses a Cargo workspace for managing Rust smart contracts and shared crates.

The root workspace configuration is defined in:

```bash
Cargo.toml
```

---

## Example Workspace Structure

```toml
[workspace]
members = [
  "contracts/*"
]
```

---

## Build All Contracts

From the repository root:

```bash
cargo build --workspace
```

---

## Run All Rust Tests

```bash
cargo test --workspace
```

---

## Lint Rust Code

```bash
cargo clippy --workspace --all-targets --all-features -- -D warnings
```

---

## Format Rust Code

```bash
cargo fmt --all
```

---

## Adding a New Contract

Inside the `contracts/` directory:

```bash
cargo new my-contract --lib
```

Then register it in the root `Cargo.toml` if necessary.

---

# Flutter App Setup

The Flutter application lives in:

```bash
app/
```

---

## Install Dependencies

```bash
flutter pub get
```

---

## Run the App

```bash
flutter run
```

---

## Analyze Flutter Code

```bash
flutter analyze
```

---

## Run Flutter Tests

```bash
flutter test
```

---

## Build APK

```bash
flutter build apk
```

---

# Smart Contract Development

All blockchain contract logic lives in:

```bash
contracts/
```

---

## Development Standards

- Prefer explicit typing
- Avoid panics in production logic
- Keep contract logic deterministic
- Write unit tests for critical logic
- Avoid unnecessary allocations
- Document public interfaces

---

## Recommended Workflow

```bash
cargo fmt --all
cargo clippy --workspace --all-targets --all-features -- -D warnings
cargo test --workspace
```

Run all checks before opening a PR.

---

# Development Commands

| Task | Command |
|------|----------|
| Install Flutter packages | `flutter pub get` |
| Run Flutter app | `flutter run` |
| Analyze Flutter app | `flutter analyze` |
| Run Flutter tests | `flutter test` |
| Build Rust workspace | `cargo build --workspace` |
| Run Rust tests | `cargo test --workspace` |
| Format Rust code | `cargo fmt --all` |
| Lint Rust workspace | `cargo clippy --workspace --all-targets --all-features -- -D warnings` |

---

# Linting & Formatting

Before pushing changes, ensure all checks pass.

---

## Flutter

```bash
dart format .
flutter analyze
```

---

## Rust

```bash
cargo fmt --all
cargo clippy --workspace --all-targets --all-features -- -D warnings
```

---

# Testing

Every contribution should include relevant tests.

---

## Flutter

Recommended:
- Widget tests
- State management tests
- UI interaction tests

Run:

```bash
flutter test
```

---

## Rust

Recommended:
- Unit tests
- Integration tests
- Edge-case validation

Run:

```bash
cargo test --workspace
```

---

# Branch Naming Convention

Use descriptive branch names.

## Format

```bash
<type>/<short-description>
```

---

## Examples

```bash
feat/add-wallet-onboarding
fix/flutter-build-errors
refactor/contract-state-management
docs/update-contributing-guide
test/add-contract-unit-tests
```

---

# Commit Message Convention

KidWallet follows Conventional Commits.

## Format

```bash
type(scope): short description
```

---

## Examples

```bash
feat(wallet): add biometric authentication

fix(contract): resolve overflow validation

docs(contributing): add flutter setup instructions

refactor(app): simplify navigation structure
```

---

## Allowed Types

| Type | Purpose |
|------|----------|
| feat | New feature |
| fix | Bug fix |
| docs | Documentation |
| refactor | Refactoring |
| test | Tests |
| chore | Maintenance |
| ci | CI/CD changes |

---

# Pull Request Guidelines

Before opening a pull request:

- Ensure tests pass
- Ensure lint passes
- Rebase on latest `main`
- Keep PRs focused
- Update documentation if needed
- Add screenshots for UI-related changes

---

## PR Title Examples

```bash
feat(wallet): implement wallet recovery flow

fix(ci): resolve cargo workspace lint failures

docs(contributing): improve setup documentation
```

---

# Code Review Expectations

Reviewers will evaluate:

- Correctness
- Readability
- Maintainability
- Test coverage
- Security implications
- Performance considerations

---

# Issue Workflow

## Before Starting Work

1. Comment on the issue
2. Wait for assignment if necessary
3. Create a feature branch
4. Keep discussions technical and focused

---

# Security Guidelines

If you discover a vulnerability:

- Do NOT create a public issue
- Notify maintainers privately
- Never commit secrets or private keys
- Rotate compromised credentials immediately

---

# Additional Notes

- Keep pull requests small and reviewable
- Avoid unrelated formatting changes
- Write meaningful commit messages
- Prefer reusable and modular code
- Maintain consistency with the existing architecture

Thank you for contributing to KidWallet 💙