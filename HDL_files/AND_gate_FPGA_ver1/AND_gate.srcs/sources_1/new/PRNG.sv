//`timescale 1ns / 1ps

//module PRNG (
//    input logic clk,            // Clock signal
//    input logic reset_n,        // Active-low reset signal
//    output real PRNG_value      // Random value output
//);

//    // Internal signal to hold the random value
//    real random_value;

//    always @(posedge clk or negedge reset_n) begin
//        if (!reset_n) begin
//            random_value <= 0.0;  // Reset PRNG output
//        end else begin
//            // Generate a random real value in the range [-1, 1]
//            random_value <= (2.0 * $urandom() / 2147483647.0) - 1.0;
//            // Ensure no value outside the range
//            // Explicit clipping to ensure range [-1, 1]
//            if (random_value > 1.0)
//                random_value <= 1.0;
//            else if (random_value < -1.0)
//                random_value <= -1.0;
//        end
//    end

//    // Assign the random value to the output
//    assign PRNG_value = (random_value > 1.0) ? 1.0 :
//                        (random_value < -1.0) ? -1.0 : random_value;

//endmodule
`timescale 1ns / 1ps

module PRNG (
    input logic clk,                  // Clock signal
    input logic reset_n,              // Active-low reset signal
    output signed [31:0] PRNG_value   // Random value output (32-bit fixed-point)
);

    // Internal signal to hold the random value
    real random_value;
    real random_value_temp;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            random_value <= 0.0;  // Reset PRNG output
        end else begin
            // Generate a random real value in the range [0, 1)
            random_value <= $urandom() / 2147483648.0; // Divide by 2147483648 to ensure [0, 1)
        end
    end
    assign random_value_temp = (random_value > 1.0) ? 1.0 :
                               (random_value < 0.0) ? 0.0 : random_value;    
                        
    // Assign the scaled and converted random value to the output
    assign PRNG_value = $signed(random_value_temp * (2.0 ** 31));

endmodule

