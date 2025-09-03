`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2025 09:28:47 AM
// Design Name: 
// Module Name: tb_downcount
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


module tb_downcount;

reg clk = 0;
reg enable = 0;
reg load = 0;
reg [7:0] val = 27;
wire [7:0] oui;

always #5 clk = ~clk;

DownCounter o1 (
    .clk(clk),
    .enable(enable),
    .load(load),
    .starting_value(val),
    .out(oui)
    );
    
    
initial begin
    #50;
    load = 1;
    #10;
    load = 0;
    #20;
    enable = 1;
    #50;
    enable = 0;
end

endmodule
