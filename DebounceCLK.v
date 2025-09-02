`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 06:39:40 PM
// Design Name: 
// Module Name: DebounceCLK
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


module DebounceCLK(
    input clkin,
    output clk_en
    );
    
    reg [26:0]counter=0;
    always @(posedge clkin)
    begin
       counter <= (counter >= 249999)? 0: counter+1;
    end
    assign clk_en = (counter == 249999) ? 1'b1:1'b0;
endmodule
