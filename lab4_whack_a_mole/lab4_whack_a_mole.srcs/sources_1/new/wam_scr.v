`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 04:21:59 PM
// Design Name: 
// Module Name: wam_scr
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


module wam_scr(             // score count
    input wire clk,         // synchronize clock
    input wire clr,
    input wire [7:0] hit,
    output reg [11:0] num,
    output wire cout0       // carry bit on 10s is a hardness control signal
    );

    wire [11:0] cnum;       // counter number register
    wire cout1, cout2;      // carry bits as trigger of next counter
    wire scr;

    assign scr = hit[0] | hit[1] | hit[2] | hit[3] | hit[4] | hit[5] | hit[6] | hit[7];

    wam_cnt cnt0( .clr(clr), .cin(scr), .cout(cout0), .num(cnum[3:0]) );
    wam_cnt cnt1( .clr(clr), .cin(cout0), .cout(cout1), .num(cnum[7:4]) );
    wam_cnt cnt2( .clr(clr), .cin(cout1), .cout(cout2), .num(cnum[11:8]) );

    always @(posedge clk) begin
        num <= cnum;        // synchronize clock
    end
endmodule // wam_scr
