`timescale 1ns / 1ps

module mealy_1011_overlap (
    input clk,
    input reset,
    input P1, // Represents '1'
    input P2, // Represents '0'
    output reg z
);

// State declaration
parameter S0 = 2'b00, 
          S1 = 2'b01, 
          S2 = 2'b10, 
          S3 = 2'b11;

reg [1:0] PS, NS; // Present State and Next State

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset)
        PS <= S0;
    else
        PS <= NS;
end

// Next state and output logic (Mealy machine)
always @(PS or P1 or P2) begin
    z = 0; // Default output
    case (PS)
        S0: if (P1) begin
                NS = S1;
            end else begin
                NS = S0;
            end
        S1: if (P1) begin
                NS = S2;
            end else if (P2) begin
                NS = S0;
            end else begin
                NS = S1;
            end
        S2: if (P2) begin
                NS = S3;
            end else begin
                NS = S1; // Overlapping sequence
            end
        S3: if (P1) begin
                z = 1; // Detecting 1101
                NS = S2;
            end else begin
                NS = S0;
            end
        default: NS = S0;
    endcase
end

endmodule
