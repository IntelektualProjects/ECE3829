`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2025 08:20:49 PM
// Design Name: 
// Module Name: CountdownCLK
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


module CountdownCLK(
    input clkin,
    output reg clkout=0
    );
    // 1Hz from 100MHz is a 100M divisor
    // 27 bits ~ 134M max value
    reg [26:0] counter = 0;
    
    
    always @(posedge clkin) begin
        // have to toggle every 100M since 1 input cycle equates to two output cycles
        if(counter == 100_000_000 - 1) begin
            counter <= 0;
            clkout <= ~clkout;
        end else
            counter <= counter + 1;
         
    end
    
endmodule
