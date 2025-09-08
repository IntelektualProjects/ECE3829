`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2025 04:06:30 PM
// Design Name: 
// Module Name: Test_top
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


module Test_top(
    input [7:0] sw,
    input clk,
    input btnL,
    input btnR,
    output [3:0] an,
    output [6:0] seg,
    output reg [15:0] led
    );
    // state encoding system
    // 00 -> BTNL Initialization
    // 01 -> Set Value state
    // 10 -> Display value on 7 Seg
    // 11 -> Count Down on Display + LED Flash
    parameter INIT = 3'b00;
    parameter SETVAL = 3'b01;
    parameter DISP = 3'b10;
    parameter COUNT = 3'b11;
    parameter PAUSE = 3'b100;
    
    // state variables
    reg [2:0] current_state;
    reg [2:0] next_state;
    
    // Enables and User variables
    reg [7:0] user_input_value;
    reg display_enable = 0;
    reg countdown_enable = 0;
    reg load_enable = 0;
    
    // Debouncer
    //wire btnR_d;
    //wire btnL_d;
    //Debouncer d0 (clk, btnL, btnL_d);
    //Debouncer d1 (clk, btnR, btnR_d);
    
    // Output Variables and modules for each state
    wire [7:0] count_out;
    wire [7:0] display_value;
    assign display_value = (current_state == COUNT || current_state == PAUSE) ? count_out : user_input_value;
    
    // Functional Blocks to Design
    DisplayTop a0 (clk, display_value, display_enable, an, seg);
    DownCounter a1 (.clk(clk), .enable(countdown_enable), .load(load_enable), .starting_value(user_input_value), .out(count_out));
    // Sequential State Logic for Moore Machine
    always @ (posedge clk) begin
        if (btnL) begin
            current_state <= INIT; //initialize
            user_input_value <= 8'b0;
        end 
        else begin
            current_state <= next_state;
        end
        
        if(current_state == SETVAL && next_state == DISP) begin
            user_input_value <= sw;
        end
    end
    
//    // Pause Logic
//    reg paused;
//    always @(posedge clk) begin
//        if (btnL) begin
//            paused <= 0;
//        end
//        else if (current_state == COUNT && btnR == 1) begin
//            paused <= ~paused; // Toggle pause on button press
//        end
//    end
    
    // Next-State Logic Combinational Block
    always @(*) begin
        case (current_state)
            INIT: begin  // Initialization
                    if(btnR)
                        next_state = SETVAL;
                    else
                        next_state = INIT;
                   end
            SETVAL:begin  // User input value
                    if(btnR)
                        next_state = DISP;
                    else
                        next_state = SETVAL;
                  end
            DISP:begin  // User value displayed on 7 Seg
                    if(btnR)
                        next_state = COUNT;
                    else
                        next_state = DISP;
                  end
            COUNT: begin // Countdown to Led flashing (pause function too)
                    if(count_out == 8'b0 && btnR == 1) 
                        next_state = DISP;
                    else if (count_out != 0 && btnR == 1)
                        next_state = PAUSE;
                    else
                        next_state = COUNT; 
                   end
            PAUSE: begin
                if (btnR)
                    next_state = COUNT;
                else
                    next_state = PAUSE;
                end
            default: next_state = INIT;
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (current_state)
            INIT: begin  // Initialization
                 display_enable = 0;
                 countdown_enable = 0;
                 load_enable = 0;
//                 led = 16'b1;
                 end
            SETVAL:begin  // User input value
                    // take in switch value before moving to next state
                    display_enable = 0;
                    countdown_enable = 0;
                    load_enable = 0;
//                    led = 16'b10;
                  end
            DISP:begin  // User value displayed on 7 Seg
                    load_enable = 1;  
                    display_enable = 1;
                    countdown_enable = 0;
//                    led = 16'b100;
                  end
            COUNT: begin // Countdown to Led flashing (pause function too)
                    load_enable = 0;
                    display_enable = 1;
                    countdown_enable = 1;
//                    led = 16'b1000;
                    end
            PAUSE: begin
                    load_enable = 0;
                    display_enable = 1;
                    countdown_enable = 0;
            end 
        endcase
    end


// 1 Hz LED Pulse at completion of down counter
     reg one_counter;
     wire slow_clk;
     CountdownCLK c0 (clk, slow_clk);
     
     always@(posedge slow_clk)
        one_counter <= one_counter + 1;
    
    always @(posedge clk) begin
        if(count_out == 0 && current_state == COUNT)begin
            if (one_counter == 1)
                led <= 16'b1111111111111111;
            else
                led <= 16'd0;
        end
        else
            led <= 16'd0;
    end
    
endmodule