`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 04:21:59 PM
// Design Name: 
// Module Name: wam_hit
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


module wam_hit (            // get successful hit condition
    input wire clk_19,
    input wire [7:0] tap,
    input wire [7:0] holes,
    output reg [7:0] hit    // effective hit
    );

    reg [7:0] holes_pre;    // holes last status

    always @ (posedge clk_19) begin
        hit <= tap & holes_pre;     // both tap and have mole, then is successful hit
        holes_pre <= holes;         // save hole status
    end
endmodule // wam_hit
