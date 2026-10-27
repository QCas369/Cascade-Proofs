# V31 experimental source-to-sign formalisation

This extension is **not yet Lean certified**. It leaves the frozen 11-theorem V10 Core untouched.

It imports the V10 theorem and evaluates 15 packed 57D integer pulse witnesses, recovering all six signed pentagon products by the recorded source dot-product convention. The 15 witness bitmask pairs are taken from the original, source-generated V10 pulse certificate, and independently decoded against all 855 integer coordinates.

**Existing independent exact checks:** original Z3×Z19 Perkel shift graph; 57 vertices, 171 edges; each pulse satisfies (A+3I)k=0 and has 20 nonzero coordinates; each prescribed support restriction has rational rank 19; signed turns multiply to [-1,+1,+1,+1,+1,+1].

**Important boundary:** The new Lean theorem (if it compiles) checks fixed pulse data, not that the two-ball coloring algorithm uniquely generated them. Formalizing that source construction, including sign normalization and the uniqueness/rank argument, is still an additional task. This file is a data-to-claim proof, not yet the entire algorithm-to-theorem chain.

No physical law, P147/P55 coupling, claimed novelty, or unconditional signal is asserted. The V10 frozen proof lives on the separate base branch and remains unchanged.