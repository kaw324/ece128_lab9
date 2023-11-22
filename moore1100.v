`timescale 1ns / 1ps

module moore1100 (
    input clk,
    input reset,
    input in,
    output reg z
);

// State declaration
parameter [2:0] 
    S0 = 3'b000, // Initial state
    S1 = 3'b001, // Detected 1
    S2 = 3'b010, // Detected 11
    S3 = 3'b011, // Detected 110
    S4 = 3'b100; // Detected 1100 (final state)

reg [2:0] PS, NS; // Present State and Next State

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) 
        PS <= S0;
    else 
        PS <= NS;
end

// Next state logic
always @(PS or in) begin
    case (PS)
        S0: NS = in ? S1 : S0;
        S1: NS = in ? S2 : S0;
        S2: NS = in ? S2 : S3;
        S3: NS = in ? S1 : S4;
        S4: NS = in ? S1 : S0;
        default: NS = S0;
    endcase
end

// Output logic (Moore machine: output depends only on the state)
always @(PS) begin
    case (PS)
        S4: z = 1; // Output is 1 only when in state S4
        default: z = 0;
    endcase
end

endmodule
