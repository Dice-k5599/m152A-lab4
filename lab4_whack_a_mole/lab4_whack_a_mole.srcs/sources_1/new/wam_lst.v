`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 04:21:59 PM
// Design Name: 
// Module Name: wam_lst
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


//debouncer logic
module wam_lst (            // digital first bit (hardness bit) flashing for tap or hardness change
    input wire clk_19,
    input wire [7:0] tap,
    input wire lft,
    input wire rgt,
    input wire cout0,
    output reg lstn
    );

    reg  [3:0] cnt;     // counter
    wire trg;           // trigger signal
    wire cout0s;        // cout0 signal conveter

    wam_tch tchc( .clk_19(clk_19), .btn(cout0), .tch(cout0s));
    assign trg = tap[0] | tap[1] | tap[2] | tap[3] | tap[4] | tap[5] | tap[6] | tap[7] | lft | rgt | cout0s;

    always @ (posedge clk_19) begin
        if (cnt > 0) begin                  // lasting
            if (cnt > 4'b0100) begin        // long enough
                cnt <= 4'b0000;
                lstn <= 0;                  // dim
            end
            else begin
                cnt <= cnt + 1;
            end
        end
        else begin                          // idle
            if (trg) begin                  // if trigger then light up
                cnt <= 4'b0001;
                lstn <= 1;
            end
        end
    end
endmodule // wam_lst
