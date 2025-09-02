`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2025 11:47:25 AM
// Design Name: 
// Module Name: TestingTop
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


module TestingTop(
    input [7:0] sw,
    input clk,
    input btnL,
    output [3:0] an,
    output [6:0] seg,
    output [15:0] led
    );
    wire [7:0] countdown_to_bcd;
    reg disp_en = 1;
    
    DownCounter a0 (.clk(clk), .enable(!btnL), .starting_value(sw), .led(led), .out(countdown_to_bcd));
    DisplayTop a1 (.clk(clk), .sw(countdown_to_bcd), .display_enable(disp_en), .an(an), .seg(seg));
    
    
endmodule
