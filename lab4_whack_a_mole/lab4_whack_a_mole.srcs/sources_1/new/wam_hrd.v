`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 04:21:59 PM
// Design Name: 
// Module Name: wam_hrd
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


module wam_hrd (            // hardness control
    input wire clk_19,
    input wire clr,
    input wire lft,
    input wire rgt,
    input wire cout0,
    output reg [3:0] hrdn          // hardness of 0~9 or H (hard)
    );

    wire lfts;      // stable left button
    wire rgts;      // stable right button
    wire cout0s;    // shorter carry signal

    wire harder;
    wire easier;

    wam_tch tchl( .clk_19(clk_19), .btn(lft), .tch(lfts));
    wam_tch tchr( .clk_19(clk_19), .btn(rgt), .tch(rgts));
    wam_tch tchc( .clk_19(clk_19), .btn(cout0), .tch(cout0s));
    assign easier = lfts;
    assign harder = rgts | cout0s;

    always @ (posedge clk_19) begin
        if (clr)
            hrdn <= 0;
        else if (easier) begin          // lft: easier
            if (hrdn > 0) begin
                hrdn <= hrdn - 1'd1;
            end
        end
        else if (harder) begin          // rgt or cout0: harder
            if (hrdn < 10) begin
                hrdn <= hrdn + 1'd1;
            end
        end
    end
endmodule // wam_hrd
