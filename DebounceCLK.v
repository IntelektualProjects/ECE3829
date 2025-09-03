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
    output reg clkout
    );
    
    reg [26:0]counter=0;
    
    always @(posedge clkin) begin
        // have to toggle every 100M since 1 input cycle equates to two output cycles
        if(counter == 25_000_000 - 1) begin
            counter <= 0;
            clkout <= ~clkout;
        end else
            counter <= counter + 1;
         
    end
    
endmodule
