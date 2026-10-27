# Cascade-Proofs

**Public Lean compilation test — V10 Core is NOT YET VERIFIED by Lean.**

This project is a deliberately limited public proof harness for an unchanged V10 Core Lean file. It is not a public release of the full Cascade / RenSphere archive.

## What is being tested

Six specified pentagon cycles of the Perkel graph have prescribed source signs `[-1,+1,+1,+1,+1,+1]`. Every one of the 15 undirected edges in those cycles occurs twice, so assigning independent scalar signs to edges can never reproduce the six signs together. That is a conditional finite combinatorial obstruction, not a physical theory. The source signs were checked computationally outside Lean and are **taken as inputs** in this module.

Exact independently replayed GF(2) cycle-incidence ranks: 5 for the 6×15 matrix, 6 for the augmented system.

## Verification

- Archived `Verification/V10_Core_Solution.lean` SHA256: `62b1d580da69d595c7115033020a2348e19032b8ec068ffed13c09bb9a539507` (unchanged copy).
- Lean: `leanprover/lean4:v4.27.0`; Mathlib: `v4.27.0`.
- GitHub Actions should compile the actual import and run an axiom audit of theorem namespace **`CascadeC04`**, not a different library namespace.
- Source does not contain `sorry`, `admit`, or `native_decide`, but that alone does **not** establish a proof.
- The full test and publication prerequisites are in [PUBLICATION_GATE.md](PUBLICATION_GATE.md).

Local reproduction after resolving dependencies:

```sh
lake update
lake exe cache get
lake build
lake env lean AxiomAudit.lean
```

**As of this initial public staging, the compiler outcome is still unknown.** We will record actual successes and failures without implying a larger physical result.

**License:** no explicit permission to reuse or modify the code has yet been granted; choose a license before any formal publication.
