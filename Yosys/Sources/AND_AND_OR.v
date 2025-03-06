module AND_AND_OR (
    input wire A1,  // First AND gate input
    input wire A2,  // Second AND gate input
    input wire B1,
	input wire B2,// Shared input for both AND gates
    output wire Y   // Final OR gate output
);
    wire and1_out, and2_out; // Wires to hold AND gate outputs

    assign and1_out = A1 & B1;  // First AND gate
    assign and2_out = A2 & B2;  // Second AND gate
    assign Y = and1_out | and2_out; // OR gate

endmodule
