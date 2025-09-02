`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2025 12:41:00 PM
// Design Name: 
// Module Name: BinarytoBCD
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


module BinarytoBCD(
    input [7:0] binary_input,
    output [3:0] ones,
    output [3:0] tens,
    output [1:0] hundreds
    );
    // data lines coming out of add3 modules
    wire [3:0] c1, c2, c3, c4, c5, c6, c7;
    
    //data lines going into add3 modules
    wire [3:0] in1, in2, in3, in4, in5, in6, in7;
    
    // assign data line inputs based on control flow diagram
    assign in1 = {1'b0, binary_input[7:5]};
    assign in2 = {c1[2:0], binary_input[4]};
    assign in3 = {c2[2:0], binary_input[3]};
    assign in4 = {c3[2:0], binary_input[2]};
    assign in5 = {c4[2:0], binary_input[1]};
    assign in6 = {1'b0, c1[3], c2[3], c3[3]};
    assign in7 = {c6[2:0], c4[3]};
    
    // instantiate add3 modules for assigned outputs
    add3 m1(in1, c1);
    add3 m2(in2, c2);
    add3 m3(in3, c3);
    add3 m4(in4, c4);
    add3 m5(in5, c5);
    add3 m6(in6, c6);
    add3 m7(in7, c7);
    
    // assign ones, tens, and hundreds place outputs
    assign ones = {c5[2:0], binary_input[0]};
    assign tens = {c7[2:0], c5[3]};
    assign hundreds = {c6[3], c7[3]};
endmodule
