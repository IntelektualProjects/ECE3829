`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2025 11:01:16 AM
// Design Name: 
// Module Name: DownCounter
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


module DownCounter(
    input clk,
    input enable,
    input load,
    input [7:0] starting_value,
    output reg [7:0] out
    );
    
    wire clk_slowed;
    
    CountdownCLK c0 (clk, clk_slowed);
    
    always @(posedge clk_slowed) begin
        // pause feature from enable pin on/off
        // enable = high, out counts down
        // enable = low, out stays same
        if (load) begin
            out <= starting_value;
        end else if (enable) begin
            if (out == 0)
                out <= 0;
            else
                out <= out - 1;
        end else
            out <= out;
    end
    
    
endmodule
