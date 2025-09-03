`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 06:42:38 PM
// Design Name: 
// Module Name: Debouncer
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


module Debouncer(
    input clk,
    input pushbutton_in,
    output pushbutton_out
    );
    
    wire slow_clk_en;
    wire Q1,Q2,Q2_bar;
    
    DebounceCLK u1(clk,slow_clk_en);
    DFF d0(slow_clk_en,pushbutton_in,Q1);
    DFF d1(slow_clk_en,Q1,Q2);
    
    assign Q2_bar = ~Q2;
    assign pushbutton_out = Q1 & Q2_bar;
    
endmodule
