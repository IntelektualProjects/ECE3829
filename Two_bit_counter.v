`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2025 02:51:48 PM
// Design Name: 
// Module Name: Two_bit_counter
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


module Two_bit_counter(
    input clk,
    output [1:0] out
    );
    reg [1:0] temp = 2'b00;
    always @ (posedge clk) begin
        temp = temp + 1;
    end
    assign out = temp;
endmodule
