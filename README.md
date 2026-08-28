# AnnLite

The official **meta-repository** for the Ann Lite ecosystem — every repository, gathered here as git submodules, so the entire platform can be cloned in one command.

> This repo holds no application code of its own. For "start here, what is Ann Lite" discoverability, see [`Ann Lite`](https://github.com/AnnLite/Ann-Lite). This repo is for **developers who want the whole ecosystem checked out locally at once**.

## What's Inside

Every repository in the Ann Lite organization, as a submodule:

| Submodule | Role |
|---|---|
| `.github` | Organization profile and shared policy |
| `annlite-design-system` | UI components and design tokens |
| `annlite-database` | Data model (PostgreSQL + Prisma) |
| `annlite-backend` | Central API |
| `annlite-payments` | Unified payment abstraction |
| `annlite-celoht` | CeloHT (blockchain) integration |
| `annlite-content` | Multilingual content |
| `annlite-web` | Public website |
| `annlite-admin` | Admin dashboard |
| `annlite-docs` | Ecosystem documentation |
| `annlite-security` | Threat model and security policy |
| `annlite-infrastructure` | Docker, CI/CD, deployment |
| `annlite-mobile` | Android/iOS app |
| `annlite-invest-book` | Investment case |
| `Ann Lite` | Discovery/landing repository |

## Cloning Everything at Once

```bash
git clone --recurse-submodules https://github.com/AnnLite/AnnLite.git
cd AnnLite
```

If you already cloned without `--recurse-submodules`:
```bash
git submodule update --init --recursive
```

## Bootstrapping (First-Time Setup)

Because submodules require their target repositories to already exist on GitHub, this repo can be created and pushed **before** every individual `annlite-*` repo exists. Use the bootstrap script to add submodules for whichever repos are already live, and re-run it as the rest come online:

```bash
./scripts/bootstrap.sh AnnLite
```

It checks each expected repository's remote and adds it as a submodule only if reachable — skipped repos are listed clearly so you know what to re-run later.

## Keeping Everything Up to Date

```bash
./scripts/update-all.sh
```

Pulls every submodule to the latest commit on its default branch (`git submodule update --remote`), rather than staying pinned to whatever commit was recorded when each was added.

## Why a Meta-Repo (and Why Submodules, Not a True Monorepo)

Ann Lite's core development principle is **one responsibility per repository** — no shared business logic duplicated across repos, no repository mixing frontend/backend/database/payments/infrastructure concerns (see the [organization README](https://github.com/AnnLite/.github)). A true monorepo would work against that by physically merging every repository's history and release cadence into one.

Git submodules give the practical benefit developers actually want — "clone once, get everything, at pinned or latest versions" — without merging the repositories themselves. Each `annlite-*` repository keeps its own independent history, versioning, CI, and access control; this repo is just a pointer set.

## Working in a Submodule

Make changes inside the relevant submodule directory as you normally would in that repository (it's a full git checkout), then push from within that submodule directory as usual. This repo (`AnnLite`) only needs a new commit if you want to record an updated submodule pointer (i.e., "the meta-repo now points at commit X of `annlite-backend`").

## Related

- [`Ann Lite`](https://github.com/AnnLite/Ann-Lite) — the discovery/landing repo, if you're not sure where to start
- [`annlite-docs`](https://github.com/AnnLite/annlite-docs) — full ecosystem architecture and policy documentation
