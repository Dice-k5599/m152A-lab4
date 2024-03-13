`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 04:31:47 PM
// Design Name: 
// Module Name: wam_cnt
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


module wam_cnt(             // 1-bit 0-to-9 counter
    input wire clr,
    input wire cin,
    output reg cout,        // carry bit
    output reg [3:0] num    // DEC number in BCD
    );

    always @(posedge cin or posedge clr) begin
        if (clr)
            begin
                num <= 0;
            end
        else
            begin
                if (num < 9)
                    begin
                        num <= num + 1;
                        cout <= 0;
                    end
                else
                    begin
                        num <= 0;
                        cout <= 1;
                    end
            end
    end
endmodule // wam_cnt
