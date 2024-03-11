`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 10:38:21 AM
// Design Name: 
// Module Name: wam_timerCount
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


module wam_timerCount(
    input clk,
	input clk_25, //1 Hz clock
	input previous_count,
	input clr,
	input pse,
	input one_second_enable,
	//input reset, //reset
	// NOTE POTENTIAL PAUSE INPUT AND FUNCTIONALITY
    output reg [3:0] right_digit,
    output reg [3:0] left_digit,
    
    output reg [7:0] displayed_number
);

always @ (posedge clk) begin

//    if (clr) begin
//        left_digit <= 3;
//        right_digit <= 0;
//    end else begin
//        if (right_digit == 0 && left_digit == 0) begin
//            left_digit <= left_digit;
//            right_digit <= right_digit;
//        end else if (right_digit == 0) begin
//            left_digit <= left_digit - 1;
//            right_digit <= 9;
//        end else begin
//            right_digit <= right_digit - 1;
//        end
//    end
// end 
   if (clr == 1)
        displayed_number <= 30;
   if (displayed_number == 0 || pse)
        displayed_number <= 0;
   else if (one_second_enable == 1)
        displayed_number <= displayed_number - 1;
   end
   
endmodule
