`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2025 02:44:36 PM
// Design Name: 
// Module Name: ledBlink
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


module ledBlink(
    input clk,
    input enable,
    output reg [15:0] led
    );
    wire clk_slow;
    CountdownCLK L0 (clk, clk_slow);
    
    always @(posedge clk_slow) begin
        if(enable)
            led <= 16'b1111111111111111;
        else
            led <= 16'b0;
    end
endmodule
