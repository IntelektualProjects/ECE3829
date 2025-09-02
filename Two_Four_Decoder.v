`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2025 02:56:09 PM
// Design Name: 
// Module Name: Two_Four_Decoder
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


module Two_Four_Decoder(
    input [1:0] enable,
    output reg [3:0] an
    );
    
    // an[3] always in off state since thousands never used
    
    always @(enable) begin
        case (enable)
            0: an = 4'b1110;
            1: an = 4'b1101;
            2: an = 4'b1011;
            3: an = 4'b1111; 
        endcase
    end
endmodule
