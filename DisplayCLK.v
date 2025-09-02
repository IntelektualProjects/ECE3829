`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2025 02:53:46 PM
// Design Name: 
// Module Name: DisplayCLK
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


module DisplayCLK(
    input clkin,
    output reg clkout
    );
    // 1KHz from 100MHz is a 100,000 divisor
    // 17 bits ~ 131K max value
    reg [20:0] counter;
    
    always @(posedge clkin) begin
        // have to toggle every 50K since 1 input cycle equates to two output cycles
        if(counter != 50_000 - 1) begin
            counter <= counter + 1; // incrememnt till clock cycle end reached
            clkout <= 0; // toggle output
        end else begin
            counter <= 0; // reset counter for next clock cycle
            clkout <= 1; // toggle output again
        end
    end 
    
    
endmodule
