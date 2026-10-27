# Cascade-Proofs

**The frozen V10 Core mathematical declarations have passed Lean 4.27.0/Mathlib compilation and the restricted axiom audit. This is NOT a physical theorem or peer-reviewed novelty claim.**

This project is a deliberately limited public proof harness for an unchanged V10 Core Lean file. It is not a public release of the full Cascade / RenSphere archive.

## What is being tested

Six specified pentagon cycles of the Perkel graph have prescribed source signs `[-1,+1,+1,+1,+1,+1]`. Every one of the 15 undirected edges in those cycles occurs twice, so assigning independent scalar signs to edges can never reproduce the six signs together. That is a conditional finite combinatorial obstruction, not a physical theory. The source signs were checked computationally outside Lean and are **taken as inputs** in this module.

Exact independently replayed GF(2) cycle-incidence ranks: 5 for the 6×15 matrix, 6 for the augmented system.

## Verification

- Archived `Verification/V10_Core_Solution.lean` SHA256: `62b1d580da69d595c7115033020a2348e19032b8ec068ffed13c09bb9a539507` (unchanged copy).
- Lean: `leanprover/lean4:v4.27.0`; Mathlib: `v4.27.0`.
- GitHub Actions should compile the actual import and run an axiom audit of importable module **`Verification`** containing declarations in theorem namespace **`CascadeC04`**.
- Source does not contain `sorry`, `admit`, or `native_decide`, but that alone does **not** establish a proof.
- The full test and publication prerequisites are in [PUBLICATION_GATE.md](PUBLICATION_GATE.md).

Local reproduction after resolving dependencies:

```sh
lake update
lake exe cache get
lake build
lake env lean AxiomAudit.lean
```

**Verified compiler checkpoint (27 October 2026):** [GitHub Actions run 40547892318](https://github.com/QCas369/Cascade-Proofs/actions/runs/40547892318) passed after increasing the build-only recursion limit. It compiled all 11 V10 core theorem declarations without modifying their original source; the axiom-audit program checked 29 declarations under importable module `Verification`, allowing only `propext`, `Classical.choice`, and `Quot.sound`. The theorem declarations themselves live in namespace `CascadeC04`. The prior two unsuccessful builds remain in the Actions history. This is an exact, conditional combinatorial claim only. Formal publication of a paper, licensing, dependency-lock archival and novelty assessment remain open.

**License:** no explicit permission to reuse or modify the code has yet been granted; choose a license before any formal publication.
