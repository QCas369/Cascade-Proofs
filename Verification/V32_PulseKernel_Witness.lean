import Verification.V31_SourceSigns_Witness

/-!
V32 computational theorem candidate: verify all 15 exact integer pulse witnesses
solve (A+3I) k = 0 for the source Perkel shifts. No pulse generation
algorithm or rank/uniqueness claim is formalized here.
-/
namespace CascadeV32

-- Six neighbors: three forward and three backward edges in Z3 x Z19.
def sourceNeighbors (v : Nat) : List Nat :=
  let i := v / 19
  let j := v % 19
  let prev := (i+2)%3
  (CascadeC04.sourceShifts i).map
      (fun d => 19*((i+1)%3)+(j+d)%19) ++
  (CascadeC04.sourceShifts prev).map
      (fun d => 19*prev+(j+19-d)%19)

def sourceKernelRow (e : Nat × Nat) (v : Nat) : ℤ :=
  3 * CascadeV31.pulseValue e v +
    ((sourceNeighbors v).map (CascadeV31.pulseValue e)).sum

set_option maxRecDepth 12000
set_option maxHeartbeats 0

theorem every_source_vertex_has_six_neighbors :
    (List.range 57).all (fun v => (sourceNeighbors v).length == 6) = true := by
  decide

theorem all_855_pulse_kernel_rows_vanish :
    CascadeC04.support.all (fun e =>
      (List.range 57).all (fun v => sourceKernelRow e v == 0)) = true := by
  decide

end CascadeV32
