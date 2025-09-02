module DisplayTop(
    input clk,
    input [7:0] sw,
    input display_enable,
    output reg [3:0] an,
    output reg [6:0] seg
    );
    
    wire clkout;
    wire [3:0] mux_out;
    wire [1:0] counter_out;
    wire [3:0] ones, tens;
    wire [1:0] hundreds;
    
    wire [3:0] an_internal;
    wire [6:0] seg_internal;
    
    // module instantiations and wiring
    BinarytoBCD a1 (sw, ones, tens, hundreds);
    Four_to_One_MUX a2 (ones, tens, hundreds, counter_out, mux_out);
    DisplayCLK a3 (clk, clkout);
    Two_bit_counter a4 (clkout, counter_out);
    Two_Four_Decoder a5 (counter_out, an_internal);
    BCDtoSevenSeg a6 (mux_out, seg_internal);
    
    // enable logic for 7 Seg display
    always @(*) begin
        if (display_enable) begin
            an  = an_internal;
            seg = seg_internal;
        end else begin
            an  = 4'b1111;       // blank all digits
            seg = 7'b1111111;    // blank all segments
        end
    end
    
    
endmodule