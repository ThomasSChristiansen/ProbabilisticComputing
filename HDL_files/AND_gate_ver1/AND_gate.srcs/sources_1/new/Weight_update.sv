module weight_function_binary(
    input logic signed [7:0] h_bipolar [0:2],     // Original bipolar h vector
    input logic signed [7:0] J_bipolar [0:2][0:2], // Original bipolar J matrix (3x3)
    input logic [2:0] m_j,                        // m_j vector as binary input (3 bits, 0 or 1)
    output logic signed [7:0] I_i [0:2]           // Output vector I_i, 3 values of 8-bit signed each
);

    // Internal variables for the binary-transformed h and J
    logic signed [7:0] h_binary [0:2];
    logic signed [7:0] J_binary [0:2][0:2];

    // Transform the J matrix and h vector to binary-compatible versions
    always_comb begin
        // Compute J_binary = 2 * J_bipolar
        for (int i = 0; i < 3; i++) begin
            for (int j = 0; j < 3; j++) begin
                J_binary[i][j] = 2 * J_bipolar[i][j];
            end
        end
        
        // Compute h_binary = h_bipolar - J_bipolar * [1, 1, 1]^T
        for (int i = 0; i < 3; i++) begin
            h_binary[i] = h_bipolar[i];
            for (int j = 0; j < 3; j++) begin
                h_binary[i] -= J_bipolar[i][j];
            end
        end
    end

    // Main calculation for I_i based on m_j and transformed J and h
    always_comb begin
        for (int i = 0; i < 3; i++) begin
            I_i[i] = h_binary[i];  // Start with the transformed h_binary value
            for (int j = 0; j < 3; j++) begin
                if (m_j[j]) begin
                    I_i[i] += J_binary[i][j];  // Add J_binary[i][j] only if m_j[j] is 1
                end
            end
        end
    end
endmodule
