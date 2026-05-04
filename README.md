# KidWallet

Tomi is eleven. Every Friday after school, his mother — call her Yetunde — used to hand him a crumpled ₦2,000 note. Half went to puff-puff at the corner stall. The other half went into a clay savings box on top of the wardrobe that he would shake every few days to guess how heavy it was getting.

Then Yetunde moved to Toronto for nursing school. The Friday allowance kept coming, but now it had to bounce through three apps and an aunt who wasn't always home. Some weeks Tomi got paid on Wednesday. Some weeks not at all. The clay box stopped getting heavier.

KidWallet is the small thing we built so Tomi could keep getting his allowance on Fridays — directly, on time, in dollars his mother sends from Toronto and his father can't accidentally spend on diesel for the generator.

## What KidWallet is

A guardian-controlled wallet for children, built on Soroban. A parent — or grandparent, or any trusted adult — provisions a wallet for a child. Money sent to that wallet is owned by the child but moves under rules the guardian sets: how much can be spent per day, on what, to whom. Savings can be locked until a birthday or a goal. Allowance can be set to drip in automatically without the parent lifting a finger.

The child gets a bright, simple Flutter app that doesn't look like a bank. The parent gets a quieter app with the controls. The contract on Soroban is the source of truth that neither of them can argue with.

## Why we built this

Three reasons, in order of weight.

First, teaching financial habits at eleven is easier than teaching them at twenty-five. We wanted a place where kids could see a balance, set a goal, watch it grow, and learn what saving actually feels like. Not a piggy bank that gets raided when the parent runs short on transport money.

Second, the diaspora angle. Roughly one in five Nigerian families has a relative sending money home, and a meaningful chunk of those flows are explicitly for a child — school fees, allowance, birthday money. Today that money lands in an adult intermediary's account. The child rarely sees it directly and the sender rarely sees what happened to it. KidWallet closes that loop.

Third, the currency story. In countries where the local currency loses 30% of its value in a year, a Naira-denominated savings habit is a habit of losing money. KidWallet defaults to USDC. The child still spends in local currency through anchor-rail off-ramps, but their balance is dollar-denominated. By the time they are old enough to care, they have been quietly hedged for a decade.

## What it does

Each child wallet is a Soroban contract instance. Inside the contract live the rules the guardian configured. The most-used ones:

**Allowance.** A guardian can set a recurring credit — "₦2,000 every Friday at 6pm" or "$5 every Monday morning". Under the hood this is a Stellar claimable balance with a time predicate the contract creates and the child's signer claims. If the wallet is empty when Friday comes, KidWallet pings the parent rather than failing silently.

**Spending limits.** Per-day, per-week, or per-merchant ceilings. A child wallet can be set to allow up to $3/day of spending freely; anything beyond that requires guardian approval through a notification on the parent's phone.

**Allowlists and blocklists.** A guardian can pre-approve specific recipients — the school's wallet, a relative, a known online merchant — and block others. Useful when the same wallet handles tuition and tuck-shop money.

**Savings vaults.** A child can move money into a time-locked vault: "I'm saving for a bike, lock this until December". The guardian can match the deposit, can release early, and can configure interest if they want to encourage the habit. Each vault is a separate Soroban contract that can only be unlocked by its predicate.

**Chore rewards.** A guardian can fund a claimable balance with a predicate the contract checks — "claimable if chore_tracker.weekly_score >= 5". Children mark chores done in the app, the guardian confirms or contests, and on Sunday the balance settles. Parents who wanted a Sticker Chart with a Stripe terminal — this is the closest we could get.

**Recovery.** If a child loses their phone, the guardian rotates the child's signer key from the parent app. No funds are at risk; the guardian holds the master key. If a guardian loses their device, a pre-configured social recovery quorum — typically three trusted adults — can restore access.

## Inside the guardian contract

The guardian contract is a small Soroban contract with three roles: `Guardian`, `Child`, and `Recovery`. The guardian sets policy. The child can spend within policy without asking. The recovery quorum exists only to rotate guardian keys if the guardian is compromised or unavailable.

Policy is stored as a structured document on the contract: spending limits, allowlists, vault references, and active claimable-balance predicates. Updates to policy require the guardian's signature; updates to *recovery* policy require the guardian plus one recovery-quorum member, so a stolen guardian key cannot lock the child out.

The contract speaks to the rest of Stellar through a thin shim. Outgoing payments are constructed by the contract and signed by the child's session key only after the contract has approved them against policy. Incoming payments — from a remitting parent in Toronto, say — land in the contract's address and are immediately credited to the child's spendable balance, minus whatever portion the policy diverts to active vaults.

The full contract is in `contracts/guardian/` and weighs in around 800 lines of Rust. It has been audited internally; an external audit is on the roadmap before we recommend mainnet use beyond family-and-friends amounts.

## The Flutter app

There are two apps in one codebase, sharing models and Stellar plumbing.

**KidWallet for kids.** Big buttons. Color-coded balance. A dashboard that says "you have $14.50, your bike vault has $48 of $120, you've done 4 of 5 chores this week." No charts, no jargon. Spending uses a tap-to-confirm pattern with an obvious cancel.

**KidWallet for parents.** A quieter, more administrative interface. Family overview if multiple children. Policy editor, transaction history per child, notifications when limits get hit. Designed to be the boring app — it should fade into the background once the policy is set.

Both are built in Flutter, both ship to iOS and Android from the same codebase, and the parent app has a web build for setup-on-laptop convenience.

## Getting started

For families:

```
Parent: download KidWallet, choose "I'm a guardian"
Parent: provision a child wallet, configure policy
Child: download KidWallet, scan the QR the parent shows them
```

That is the whole onboarding. The parent's wallet funds the child contract; the child's spendable balance starts at whatever the parent transferred.

For developers who want to run KidWallet locally:

```bash
git clone https://github.com/labakemi/kidwallet.git
cd kidwallet

# Build and deploy the contract to Soroban testnet
cd contracts/guardian
soroban contract build
soroban contract deploy \
  --network testnet \
  --wasm target/wasm32-unknown-unknown/release/guardian.wasm

# Run the apps
cd ../../app
flutter run -d chrome   # parent web build
flutter run             # whichever device is plugged in
```

Soroban CLI 21+, Rust 1.78+, Flutter 3.22+. Full setup notes in `docs/dev-setup.md`.

## Where this is going

The next obvious things, roughly in the order we plan to build them:

- A teacher-facing variant where a school can issue a class wallet and disburse to multiple child wallets — think field-trip allowances
- Soroban-native interest on savings vaults, sourced from a small whitelisted set of low-risk pools
- Anchor partnerships in Nigeria, Kenya, and Ghana so children can spend through Verve, M-Pesa, and MTN Mobile Money respectively
- A "first job" mode for older teens that gradually relaxes guardianship — at 16 the guardian can opt the wallet into a more permissive policy class
- A graduation pathway at 18 that converts the wallet to a standard Stellar account, optionally with a financial-literacy attestation the child can show to a future employer

## A note to parents

We are not trying to make your child a crypto trader. We are trying to make a piggy bank that survives a remittance, doesn't get raided, and grows up with them.

If your child uses KidWallet for a year and at the end of that year they understand that money is something you choose what to do with — that you can save it, that saving feels like something, that what you save buys you something later — then the project worked, regardless of what else happens in this industry. That is the whole brief.

We do not collect data about children. The Flutter app sends no analytics and no telemetry. The only persistent identifier a child has is their Stellar public key, which their guardian controls. KidWallet does not know your child's name unless you typed it in for the cute UI label, and we do not know it either — it lives on the device.

If you find a bug or you have a feature request from a parent's perspective, the issue tracker is open and we read every one. Most of what is in this document came from those issues.

## License

Apache 2.0 for the contract code. MIT for the Flutter app. The contract is the part that holds your child's money; we wanted the most permissive practical license on it so anyone can audit, fork, and extend it.
