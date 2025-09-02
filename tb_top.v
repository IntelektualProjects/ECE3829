`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2025 09:28:57 AM
// Design Name: 
// Module Name: tb_top
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


module tb_top;

reg [7:0] sw;
reg clk;
reg btnL, btnR;
wire [3:0] an;
wire [6:0] seg;
wire [15:0] led; 


always #5 clk = ~clk;

FSMTrial(
    .sw(sw),
    .clk(clk),
    .btnL(btnL),
    .btnR(btnR),
    .an(an),
    .seg(seg),
    .led(led)
    );
    
    initial begin
        sw = 0;
        btnL = 1;
        #2;
        btnL = 0;
        #10;
        sw = 9;
        #10;
        btnR = 1; // setval?
        #2;
        btnR = 0;
        #10;
        btnR = 1; // disp
        #2;
        btnR = 0;
        #10;
        btnR = 1; // countdown
        #2;
        btnR = 0;
        #10;

    end

endmodule
