(* techmap_celltype = "$_ANDNOT_" *)
module _ANDNOT_ (input A, input B, output Y);
    wire nb;
    // Replace ANDNOT: Y = A & ~B
    $_NOT_ inst_not (.A(B), .Y(nb));
    $_AND_ inst_and (.A(A), .B(nb), .Y(Y));
endmodule

(* techmap_celltype = "$_ORNOT_" *)
module _ORNOT_ (input A, input B, output Y);
    wire nb;
    // Replace ORNOT: Y = A | ~B
    $_NOT_ inst_not (.A(B), .Y(nb));
    $_OR_ inst_or (.A(A), .B(nb), .Y(Y));
endmodule