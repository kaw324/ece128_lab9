`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/13 14:25:01
// Design Name: 
// Module Name: lab9a
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lab9a (
    input RAW,   // Raw input from the switch
    input CLK,   // Clock signal
    output reg CLEAN // Debounced output
);

// Internal counter and Terminal Count (TC) signal
reg [2:0] counter; // 3-bit counter
wire TC;           // Terminal count signal

// Reset and increment counter
always @(posedge CLK) begin
    if (~RAW) begin
        counter <= 3'b000; // Reset counter if RAW is low
    end else begin
        counter <= counter + 3'b001; // Increment counter
    end
end

// Generate Terminal Count signal
assign TC = (counter == 3'b111);

// Change output signal when counter reaches max
always @(posedge CLK) begin
    if (~RAW) begin
        CLEAN <= 1'b0; // Set CLEAN low if RAW is low
    end else if (TC) begin
        CLEAN <= 1'b1; // Set CLEAN high if counter reaches max
    end
end

endmodule

