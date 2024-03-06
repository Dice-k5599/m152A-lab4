`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 04:21:59 PM
// Design Name: 
// Module Name: wam_tap
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


module wam_tap (            // input switch
    input wire clk_19,
    input wire [7:0] sw,
    output reg [7:0] tap    // active high
    );

    reg [7:0]  sw_pre;      // last status
    wire [7:0] sw_edg;      // bilateral edge trigger
    reg [31:0] sw_cnt;      // state machine counter
    integer i;              // switch selector

    always @(posedge clk_19)    // bilateral edge detection
        sw_pre <= sw;
    assign sw_edg = ((sw_pre) & (~sw)) | ((~sw_pre) & (sw));

    always @ (posedge clk_19) begin
        for (i=0; i<8; i=i+1) begin
            if (sw_cnt[4*i+:4] > 0) begin               // filtering
                if (sw_cnt[4*i+:4] > 4'b0100) begin     // stable
                    sw_cnt[4*i+:4] <= 4'b0000;
                    tap[i] <= 1;                        // output status
                end
                else begin
                    if (sw_edg[i]) begin                // if switch then back to idle
                        sw_cnt[4*i+:4] <= 0;
                    end
                    else begin                          // count
                        sw_cnt[4*i+:4] <= sw_cnt[4*i+:4] + 1;
                    end
                end
            end
            else begin                                  // idle
                tap[i] <= 0;
                if (sw_edg[i]) begin                    // if switch then start filtering
                    sw_cnt[4*i+:4] <= 4'b0001;
                end
            end
        end
    end
endmodule // wam_tap
