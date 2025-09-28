`timescale 1ns / 1ps

// FOR USE WITH AN FPGA THAT HAS 12 PINS FOR RGB VALUES, 4 PER COLOR


module vga_test(
	input clk_100MHz,      // from FPGA
	input btnL, btnR, btnU, btnC, btnD,
	output hsync, 
	output vsync,
	output [11:0] rgb      // 12 FPGA pins for RGB(4 per color)
);
	
	// Signal Declaration
	reg [11:0] rgb_reg;    // Register for displaying color on a screen
	wire video_on;         // Same signal as in controller
	wire ptick;            // the 25MHz pixel/second rate signal, pixel tick
	wire [9:0] x_pos;      // pixel count/position of pixel x, max 0-799
	wire [9:0] y_pos;      // pixel count/position of pixel y, max 0-524
	wire slowclk;

    // Instantiate VGA Controller
    vga_controller vga_c(.clk_100MHz(clk_100MHz), .reset(1'b0), .hsync(hsync), .vsync(vsync),
                         .video_on(video_on), .p_tick(ptick), .x(x_pos), .y(y_pos));
                         
    Clock_25Hz c0 (clk_100MHz, 1'b0, slowclk);

    parameter BORDER = 8;
    parameter PTR_SIZE = 8;
    parameter PTR_SIZE_HALF = 4;
    
    parameter SCREEN_W = 640;
    parameter SCREEN_H = 480;
    parameter CENTER_X = 320 - PTR_SIZE_HALF;  // 640 / 2
    parameter CENTER_Y = 240 - PTR_SIZE_HALF;  // 480 / 2
    
    reg [9:0] ptr_x = CENTER_X;
    reg [9:0] ptr_y = CENTER_Y;
    
    always @(posedge slowclk) begin
        if(btnC) begin
            ptr_x <= CENTER_X;
            ptr_y <= CENTER_Y;
        end else begin
                // diagonal top left
            if(btnU && btnL && ptr_y - PTR_SIZE >= BORDER && ptr_x - PTR_SIZE >= BORDER) begin 
                ptr_y <= ptr_y - PTR_SIZE;
                ptr_x <= ptr_x - PTR_SIZE;
                //diagonal up right
            end else if(btnU && btnR && ptr_y - PTR_SIZE >= BORDER && ptr_x + PTR_SIZE < (SCREEN_W - BORDER - PTR_SIZE)) begin
                ptr_y <= ptr_y - PTR_SIZE;
                ptr_x <= ptr_x + PTR_SIZE;
                // diagonal down left
            end else if(btnD && btnL && ptr_y + PTR_SIZE < (SCREEN_H - BORDER - PTR_SIZE) && ptr_x - PTR_SIZE >= BORDER) begin
                ptr_y <= ptr_y + PTR_SIZE;
                ptr_x <= ptr_x - PTR_SIZE;
                // diagonal down right
            end else if(btnD && btnR && ptr_y + PTR_SIZE < (SCREEN_H - BORDER - PTR_SIZE) && ptr_x + PTR_SIZE < (SCREEN_W - BORDER - PTR_SIZE)) begin
                ptr_y <= ptr_y + PTR_SIZE;
                ptr_x <= ptr_x + PTR_SIZE;
                // left
            end else if(btnL && ptr_x - PTR_SIZE > BORDER)
                ptr_x <= ptr_x - PTR_SIZE;
                // right
            else if(btnR && ptr_x + PTR_SIZE < (SCREEN_W - BORDER - PTR_SIZE))
                ptr_x <= ptr_x + PTR_SIZE;
                // up
            else if(btnU && ptr_y - PTR_SIZE > BORDER)
                ptr_y <= ptr_y - PTR_SIZE;
                // down
            else if(btnD && ptr_y + PTR_SIZE < (SCREEN_H - BORDER - PTR_SIZE))
                ptr_y <= ptr_y + PTR_SIZE;
       end
    end
    
    
    
    always @(posedge clk_100MHz) begin
        if (~video_on)
            rgb_reg <= 12'h000;  // outside visible area
        // Red border: top/bottom or left/right 8 pixels
        else if (x_pos < BORDER || x_pos >= (SCREEN_W - BORDER) ||
                 y_pos < BORDER || y_pos >= (SCREEN_H - BORDER))
            rgb_reg <= 12'h00F;
        // Pointer: white 8x8 square
        else if (x_pos >= ptr_x && x_pos < (ptr_x + PTR_SIZE) &&
                 y_pos >= ptr_y && y_pos < (ptr_y + PTR_SIZE))
               rgb_reg <= 12'hFFF;
        else
            rgb_reg <= 12'h000; // black background
    end
    
    // Output
    assign rgb = rgb_reg;   // while in display area RGB color = sw, else all OFF
        
endmodule