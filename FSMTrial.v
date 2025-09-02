`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2025 12:29:20 PM
// Design Name: 
// Module Name: FSMTrial
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


module FSMTrial(
    input [7:0] sw,
    input clk,
    input btnL,
    input btnR,
    output [3:0] an,
    output [6:0] seg,
    output [15:0] led
    );
    
    // state encoding system
    // 00 -> BTNL Initialization
    // 01 -> Set Value state
    // 10 -> Display value on 7 Seg
    // 11 -> Count Down on Display + LED Flash
    parameter INIT = 2'b00;
    parameter SETVAL = 2'b01;
    parameter DISP = 2'b10;
    parameter COUNT = 2'b11;
    parameter DONE = 3'b100;
    
    // state variables
    reg [1:0] current_state;
    reg [1:0] next_state;
    
    // Enables and User variables
    reg [7:0] user_input_value;
    reg display_enable = 0;
    reg countdown_enable = 0;
    reg load_enable = 0;
    //reg led_enable = 0;
    
    
    // Output Variables and modules for each state
    wire [7:0] count_out;
    wire [7:0] display_value;
    assign display_value = (current_state == COUNT) ? count_out : user_input_value;
    
    // Functional Blocks to Design
    DisplayTop a0 (clk, display_value, display_enable, an, seg);
    DownCounter a1 (.clk(clk), .enable(countdown_enable), .load(load_enable), .starting_value(user_input_value), .out(count_out));
    ledBlink(.clk(clk), .enable(current_state == COUNT), .led(led));
    
    //Debouncers for the buttons
    wire btnL_d;
    wire btnR_d;
    Debouncer d0 (clk, btnL, btnL_d);
    Debouncer d1 (clk, btnR, btnR_d);
    
    // Sequential State Logic for Moore Machine
    always @ (posedge clk) begin
        if (btnL_d) begin
            current_state <= INIT;
        end else begin
            current_state <= next_state;
        end
        
    end
    
    // Next-State Logic Combinational Block
    always @(*) begin
        case (current_state)
            INIT: begin  // Initialization
                    if(btnL_d)
                        next_state = SETVAL;
                    end
            SETVAL:begin  // User input value
                    if(btnR_d) begin
                        next_state = DISP;
                    end
                  end
            DISP:begin  // User value displayed on 7 Seg
                    if(btnR_d)
                        next_state = COUNT;
                  end
            COUNT: begin // Countdown to Led flashing (pause function too)
                    if(count_out == 8'b0 && btnR_d == 1) 
                        next_state = DISP;
                   end
//            DONE: begin
//                    if(btnR_d)
//                        next_state = DISP;
//                end
            default: next_state = INIT;
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (current_state)
            INIT: begin  // Initialization
                 user_input_value = 8'b00000000;
                 display_enable = 0;
                 countdown_enable = 0;
                 load_enable = 0;
                 end
            SETVAL:begin  // User input value
                    // take in switch value before moving to next state
                    user_input_value = sw;
                    display_enable = 0;
                    countdown_enable = 0;
                    load_enable = 0;
                  end
            DISP:begin  // User value displayed on 7 Seg
                    load_enable = 1;  
                    display_enable = 1;
                    countdown_enable = 0;
                  end
            COUNT: begin // Countdown to Led flashing (pause function too)
                    load_enable = 0;
                    display_enable = 1;
                    countdown_enable = 1;
                    if (btnR_d == 1 && count_out != 0) begin
                        countdown_enable = ~countdown_enable;
                    end
                  end
//            DONE: begin
//                led_enable = 1;
//            end   
        endcase
    end

    
endmodule
