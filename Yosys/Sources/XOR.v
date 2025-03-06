`timescale 1ns/1ps

module xor_chain(
    input  wire A,   // First input to gate 1
    input  wire B,   // Second input to gate 1
    input  wire D,   // Input to gate 2 (with output of gate 1)
    input  wire F,   // Input to gate 3 (with output of gate 2)
    input  wire H,   // Input to gate 4 (with output of gate 3)
    input  wire J,   // Input to gate 5 (with output of gate 4)
    input  wire L,   // Input to gate 6 (with output of gate 5)
    input  wire N,   // Input to gate 7 (with output of gate 6)
    input  wire P,   // Input to gate 8 (with output of gate 7)
    output wire C,   // Output of gate 1: A XOR B
    output wire E,   // Output of gate 2: C XOR D
    output wire G,   // Output of gate 3: E XOR F
    output wire I,   // Output of gate 4: G XOR H
    output wire K,   // Output of gate 5: I XOR J
    output wire M,   // Output of gate 6: K XOR L
    output wire O,   // Output of gate 7: M XOR N
    output wire Q    // Output of gate 8: O XOR P
);

    // Gate 1: A XOR B -> C
    xor U1 (C, A, B);

    // Gate 2: C XOR D -> E
    xor U2 (E, C, D);

    // Gate 3: E XOR F -> G
    xor U3 (G, E, F);

    // Gate 4: G XOR H -> I
    xor U4 (I, G, H);

    // Gate 5: I XOR J -> K
    xor U5 (K, I, J);

    // Gate 6: K XOR L -> M
    xor U6 (M, K, L);

    // Gate 7: M XOR N -> O
    xor U7 (O, M, N);

    // Gate 8: O XOR P -> Q
    xor U8 (Q, O, P);

endmodule
