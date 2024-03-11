`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 04:21:59 PM
// Design Name: 
// Module Name: wam_dis
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


module wam_dis(             // handle digital tube output
    input clk_16,
    input clk_25,
    input wire  [3:0]  hrdn,
    input wire  [11:0] score,
    input wire  lstn,
    
    input wire count,
    input wire [3:0] left_digit, // left most digit
    input wire [3:0] right_digit,// 2nd digit from the left
    input [7:0] displayed_number,
    output reg  [3:0]  an,
    output wire [6:0]  a2g
    );

    reg [1:0] clk_16_cnt;   // counter
    reg [3:0] dnum;         // displaying number
    reg [3:0] tenth_digit;
    reg [3:0] one_digit;
    
    always @ (posedge clk_16) begin
        clk_16_cnt <= clk_16_cnt + 1;
    end

    always @(*) begin
        tenth_digit <= left_digit;
        one_digit <= right_digit;
        
        case(clk_16_cnt)    // choose which display to display
            2'b00: begin
                dnum <= score[3:0];
                an <= 4'b1110;
            end
            2'b01: begin
                dnum <= score[7:4];
                an <= 4'b1101;
            end
            2'b10: begin
                // orginal
                // dnum = score[11:8];
                // modified
                dnum <= displayed_number % 10;
                an <= 4'b1011;
            end
            2'b11: begin
                // original 
//                dnum = hrdn;
//                if (lstn)
//                    an = 4'b0111;
//                else
//                    an = 4'b1111;
                // modified
                dnum <= displayed_number / 10;
                an <= 4'b0111;
            end
        endcase
    end
    wam_obd obd( .num(dnum), .a2g(a2g) );
endmodule // wam_dis

