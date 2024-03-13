`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 04:27:02 PM
// Design Name: 
// Module Name: wam_rdn
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


module wam_rdn(             // generate 8-bit random number
    input wire clk,
    input wire load,
    input wire [7:0] seed,
    output reg [7:0] num
    );

    always @( posedge clk or posedge load ) begin
        if(load)
            num <= seed;            // load seed
        else begin                  // shift with feed back
            num[0] <= num[7];
            num[1] <= num[0];
            num[2] <= num[1];
            num[3] <= num[2];
            num[4] <= num[3]^num[7];
            num[5] <= num[4]^num[7];
            num[6] <= num[5]^num[7];
            num[7] <= num[6];
        end
    end
endmodule // wam_rdn
