module FA (
    input wire a,     // First input bit
    input wire b,     // Second input bit
    input wire cin,   // Carry input
    output wire sum,  // Sum output
    output wire cout  // Carry output
);

    // Sum is computed using XOR gates
    assign sum = a ^ b ^ cin;
    
    // Carry out is computed using AND and OR gates
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule
