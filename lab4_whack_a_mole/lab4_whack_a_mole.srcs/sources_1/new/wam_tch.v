`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 04:33:02 PM
// Design Name: 
// Module Name: wam_tch
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


module wam_tch (            // input button
    input wire clk_19,
    input wire btn,
    output reg tch              // active high
    );

    reg  btn_pre;               // button last status
    wire btn_edg;               // posedge trigger
    reg  [3:0] btn_cnt;         // counter

    always @(posedge clk_19)    // posedge detection
        btn_pre <= btn;
    assign btn_edg = (~btn_pre) & (btn);

    always @ (posedge clk_19) begin
        if (btn_cnt > 0) begin                  // filtering
            if (btn_cnt > 4'b0100) begin        // stable
                btn_cnt <= 4'b0000;
                tch <= 1;                       // output status
            end
            else begin
                if (btn_edg) begin              // if button then back to idle
                    btn_cnt <= 0;
                end
                else begin                      // count
                    btn_cnt <= btn_cnt + 1;
                end
            end
        end
        else begin                              // idle
            tch <= 0;
            if (btn_edg) begin                  // if button pressed then start filtering
                btn_cnt <= 4'b0001;
            end
        end
    end
endmodule // wam_tch
