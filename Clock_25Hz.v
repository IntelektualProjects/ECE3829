`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2025 08:42:01 PM
// Design Name: 
// Module Name: Clock_25Hz
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


module Clock_25Hz (
    input clk_100MHz,
    input reset,
    output reg clk_25Hz
);
    // 100 MHz / 25 Hz = 4,000,000 cycles per period, so toggle every 2,000,000
    localparam DIV_COUNT = 2_000_000; 

    reg [21:0] count; // needs to count up to 2,000,000 (2^22 = 4,194,304)

    always @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            count <= 0;
            clk_25Hz <= 0;
        end else begin
            if (count == DIV_COUNT - 1) begin
                count <= 0;
                clk_25Hz <= ~clk_25Hz; // toggle every 2,000,000 cycles
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule
