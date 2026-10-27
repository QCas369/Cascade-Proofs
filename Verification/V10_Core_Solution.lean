import Mathlib

/-!
Cascade C04: restricted six-pentagon sign obstruction.
Independent combinatorial data, source signs as declared inputs.
No claim to formalize source pulse generation or novel physical dynamics.
-/

namespace CascadeC04

def cycles : List (List Nat) :=
  [
    [0, 30, 10, 36, 40],
    [0, 30, 53, 1, 41],
    [0, 40, 31, 1, 41],
    [1, 21, 10, 30, 53],
    [1, 21, 10, 36, 42],
    [1, 31, 40, 36, 42]]

def undirectedEdge (u v : Nat) : Nat × Nat :=
  if u ≤ v then (u, v) else (v, u)

def cycleEdges (c : List Nat) : List (Nat × Nat) :=
  (c.zip (c.drop 1 ++ c.take 1)).map (fun p => undirectedEdge p.1 p.2)

def allEdges : List (Nat × Nat) := cycles.flatMap cycleEdges

def support : List (Nat × Nat) :=
  [
    (0, 30),
    (0, 40),
    (0, 41),
    (1, 21),
    (1, 31),
    (1, 41),
    (1, 42),
    (1, 53),
    (10, 21),
    (10, 30),
    (10, 36),
    (30, 53),
    (31, 40),
    (36, 40),
    (36, 42)]

/-! These signs are input from the P32 pulse calculation, not derived in Lean. -/
def sourceSigns : List ℤ := [-1, 1, 1, 1, 1, 1]

/-! Each scalar edge sign would occur exactly twice across the six loops. -/
def edgeSquareProduct (s : Fin 15 → ℤ) : ℤ :=
    (s (0 : Fin 15) * s (0 : Fin 15)) *
    (s (1 : Fin 15) * s (1 : Fin 15)) *
    (s (2 : Fin 15) * s (2 : Fin 15)) *
    (s (3 : Fin 15) * s (3 : Fin 15)) *
    (s (4 : Fin 15) * s (4 : Fin 15)) *
    (s (5 : Fin 15) * s (5 : Fin 15)) *
    (s (6 : Fin 15) * s (6 : Fin 15)) *
    (s (7 : Fin 15) * s (7 : Fin 15)) *
    (s (8 : Fin 15) * s (8 : Fin 15)) *
    (s (9 : Fin 15) * s (9 : Fin 15)) *
    (s (10 : Fin 15) * s (10 : Fin 15)) *
    (s (11 : Fin 15) * s (11 : Fin 15)) *
    (s (12 : Fin 15) * s (12 : Fin 15)) *
    (s (13 : Fin 15) * s (13 : Fin 15)) *
    (s (14 : Fin 15) * s (14 : Fin 15))

theorem thirty_edge_occurrences : allEdges.length = 30 := by decide

theorem fifteen_distinct_edges : support.length = 15 := by decide

theorem each_edge_twice :
    support.all (fun e => (allEdges.filter (fun f => f == e)).length == 2) = true := by decide

theorem recorded_sign_product : sourceSigns.prod = -1 := by decide

theorem scalar_sign_obstruction (s : Fin 15 → ℤ)
    (hs : ∀ i, s i = 1 ∨ s i = -1) :
    edgeSquareProduct s ≠ sourceSigns.prod := by
  have sq : ∀ i : Fin 15, s i * s i = 1 := by
    intro i
    rcases hs i with h | h <;> simp [h]
  simp [edgeSquareProduct, sourceSigns, sq]

/-! V10: prove the six actual cycle products yield the edge-square polynomial. -/

def sourceShifts (block : Nat) : List Nat :=
  if block == 0 then [1,7,11]
  else if block == 1 then [4,6,9]
  else [5,16,17]

def generatedPerkelEdges : List (Nat × Nat) :=
  (List.range 3).flatMap (fun i =>
    (List.range 19).flatMap (fun j =>
      (sourceShifts i).map (fun d =>
        undirectedEdge (19*i+j) (19*((i+1)%3)+(j+d)%19))))

def loopGain (s : Nat × Nat → ℤ) (c : List Nat) : ℤ :=
  ((cycleEdges c).map s).prod

theorem fifteen_really_distinct_edges : support.Nodup := by decide

theorem all_cycle_edges_in_support :
    allEdges.all (fun e => support.contains e) = true := by decide

theorem all_cycle_edges_from_Perkel_shifts :
    allEdges.all (fun e => generatedPerkelEdges.contains e) = true := by decide

theorem Perkel_shift_edge_count : generatedPerkelEdges.length = 171 := by decide

theorem every_actual_loop_gain_factors_into_squares (s : Nat × Nat → ℤ) :
    (cycles.map (loopGain s)).prod =
      (support.map (fun e => s e * s e)).prod := by
  simp [cycles, loopGain, cycleEdges, undirectedEdge, support]
  ring

theorem no_scalar_signs_match_six_actual_cycle_gains
    (s : Nat × Nat → ℤ)
    (hs : ∀ e, s e = 1 ∨ s e = -1) :
    (cycles.map (loopGain s)).prod ≠ sourceSigns.prod := by
  have h : ∀ e, s e * s e = 1 := by
    intro e
    rcases hs e with he | he <;> simp [he]
  have ht : (cycles.map (loopGain s)).prod = 1 := by
    rw [every_actual_loop_gain_factors_into_squares]
    simp [h]
  rw [ht, recorded_sign_product]
  norm_num

end CascadeC04
