/* Generated by Yosys 0.50+56 (git sha1 78960292d, x86_64-w64-mingw32-g++ 13.2.1 -O3) */

(* top =  1  *)
(* src = "AND_gate.v:1.1-9.10" *)
module AND_gate(a, b, y);
  (* src = "AND_gate.v:2.16-2.17" *)
  input a;
  wire a;
  (* src = "AND_gate.v:3.16-3.17" *)
  input b;
  wire b;
  (* src = "AND_gate.v:4.16-4.17" *)
  output y;
  wire y;
  assign y = b & a;
endmodule
