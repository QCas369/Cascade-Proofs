import Verification.V10_Core_Solution

/-! V31 source-pulse witness, compressed from the exact 15-vector Perkel
certificate. This file checks the six recorded signs as a finite calculation
over original source pulse vectors. It does not formalize their BFS generation
or the rank-19 uniqueness argument, which remain separate source checks. -/
namespace CascadeV31

-- Each entry packs +1 and -1 coordinates of a 57D integer pulse as two
-- disjoint bitmasks, in CascadeC04.support order.
def packedPulses : List (Nat × Nat) := [
  (90071992583195528, 1988066004713472),
  (9007212157059616, 108794785816391680),
  (2251869072793652, 18142217021686784),
  (74309411048263885, 4654245949210640),
  (36029071968442128, 3975857132044288),
  (18014424314119232, 73474658434834432),
  (36284434042849281, 4503738145587304),
  (563053042469008, 2587838071767552),
  (175958368067845, 18018247091159072),
  (72576374249988, 77128717771481088),
  (81064797588310184, 36187550049636352),
  (351966195089420, 18046284355109216),
  (9236447430214916, 290306778472512),
  (2042893141301252, 22518139919008512),
  (29344075559731481, 19810343723040)]

def pulseValue (e : Nat × Nat) (v : Nat) : ℤ :=
  let masks := packedPulses[CascadeC04.support.idxOf e]!
  (if masks.1.testBit v then (1 : ℤ) else 0) -
    (if masks.2.testBit v then (1 : ℤ) else 0)

def pulseDot (e f : Nat × Nat) : ℤ :=
  ((List.range 57).map (fun v => pulseValue e v * pulseValue f v)).sum

def pulseTurn (u v w : Nat) : ℤ :=
  pulseDot (CascadeC04.undirectedEdge u v) (CascadeC04.undirectedEdge v w) / 2

def pulsePentagonGain (c : List Nat) : ℤ :=
  ((List.range 5).map (fun i =>
    pulseTurn (c.getD ((i+4)%5) 0) (c.getD i 0) (c.getD ((i+1)%5) 0))).prod

set_option maxRecDepth 12000
set_option maxHeartbeats 0

theorem six_signs_from_frozen_pulse_witnesses :
    CascadeC04.cycles.map pulsePentagonGain = CascadeC04.sourceSigns := by
  decide

end CascadeV31
