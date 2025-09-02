module Four_to_One_MUX(
    input [3:0] A,
    input [3:0] B,
    input [1:0] C,
    input [1:0] selector,
    output [3:0] mux_out
    );
    
    assign mux_out = (selector == 0) ? A:
                      (selector == 1) ? B: 
                      (selector == 2) ? C:4'b0000;
endmodule